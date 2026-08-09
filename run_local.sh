#!/usr/bin/env bash
set -euo pipefail

# 本地运行脚本 - 无需 Docker，直接在电脑上运行 Sherlock

# 配置参数
ZIP_URL="https://github.com/sherlock-project/sherlock/archive/refs/heads/master.zip"
WORKDIR="./sherlock"
OUTPUT_DIR="./output"
USERNAME="${S_USERNAME:-${1:-daweiwei}}"  # 默认搜索 daweiwei，可传入参数覆盖

# 创建必要目录
mkdir -p "$OUTPUT_DIR" ./tmp
cd ./tmp

echo "[run_local.sh] 用户名: $USERNAME"
echo "[run_local.sh] 输出目录: $(cd .. && pwd)/$OUTPUT_DIR"
echo ""

# 第一步：下载 Sherlock
echo "[run_local.sh] 正在下载 sherlock master.zip..."
if command -v wget >/dev/null 2>&1; then
  wget -q -O master.zip "$ZIP_URL"
  echo "✓ 下载完成 (using wget)"
elif command -v curl >/dev/null 2>&1; then
  curl -sL -o master.zip "$ZIP_URL"
  echo "✓ 下载完成 (using curl)"
else
  echo "✗ 错误：找不到 wget 或 curl，请先安装其中之一"
  exit 1
fi

# 第二步：解压
echo "[run_local.sh] 正在解压..."
if command -v unzip >/dev/null 2>&1; then
  unzip -q master.zip
else
  # 尝试用 Python 解压（如果没有 unzip）
  python3 -m zipfile -e master.zip .
fi
echo "✓ 解压完成"

# 找到解压后的目录
EXTRACT_DIR=$(find . -maxdepth 1 -type d -name "sherlock*" | head -n 1)
if [ -z "$EXTRACT_DIR" ]; then
  echo "✗ 错误：找不到解压后的 sherlock 目录"
  ls -la
  exit 1
fi

# 进入 sherlock 目录
cd "$EXTRACT_DIR"

# 第三步：安装依赖
echo "[run_local.sh] 正在安装 Python 依赖..."
if [ -f requirements.txt ]; then
  # 使用 --user 让普通用户也能安装，避免权限问题
  pip install --user --no-cache-dir -r requirements.txt 2>&1 | grep -E "(Successfully|Requirement|error)" || true
  echo "✓ 依赖安装完成"
else
  echo "⚠ 找不到 requirements.txt，跳过依赖安装"
fi

# 第四步：运行 Sherlock
echo "[run_local.sh] 正在运行 Sherlock，搜索用户名: $USERNAME"
echo "=================================================="

TIMESTAMP=$(date -u +"%Y%m%dT%H%M%SZ")
OUTFILE="../$(cd ../.. && pwd)/$OUTPUT_DIR/sherlock_${USERNAME}_${TIMESTAMP}.txt"

# 尝试运行 sherlock
if [ -f sherlock.py ]; then
  python3 sherlock.py "$USERNAME" | tee "$OUTFILE" || true
elif python3 -c "import importlib; importlib.import_module('sherlock')" >/dev/null 2>&1; then
  python3 -m sherlock "$USERNAME" | tee "$OUTFILE" || true
else
  python3 -m sherlock "$USERNAME" | tee "$OUTFILE" || true
fi

echo "=================================================="
echo ""
echo "✓ 完成！结果已保存到:"
echo "  $OUTFILE"
echo ""
echo "最后 50 行输出:"
tail -n 50 "$OUTFILE" 2>/dev/null || echo "（无输出）"
