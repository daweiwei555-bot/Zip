# 本地运行指南

现在你可以完全免费地在本地电脑上运行 Sherlock，无需 Render 或 Docker！

## 前置要求

确保你的电脑已安装：
- **Python 3.8+** （检查：`python3 --version`）
- **wget 或 curl** （用于下载文件）
- **unzip** （用于解压文件）

### Windows 用户
如果是 Windows，可以：
1. 安装 [Git Bash](https://gitforwindows.org/) 或 [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install)
2. 然后按下面步骤运行

### macOS 用户
```bash
# 如果没有 wget，可用 Homebrew 安装
brew install wget
```

### Linux 用户
```bash
# Ubuntu/Debian
sudo apt-get install wget unzip

# CentOS/RHEL
sudo yum install wget unzip
```

---

## 快速开始

### 第一步：克隆仓库
```bash
git clone https://github.com/daweiwei555-bot/Zip.git
cd Zip
```

### 第二步：运行脚本

**方式 A：搜索默认用户名 (daweiwei)**
```bash
bash run_local.sh
```

**方式 B：搜索自定义用户名**
```bash
bash run_local.sh your_username
# 或
S_USERNAME=your_username bash run_local.sh
```

### 第三步：查看结果
```bash
ls -la output/
cat output/sherlock_*.txt
```

---

## 脚本做了什么？

`run_local.sh` 自动执行以下步骤：

1. ✓ 下载最新的 Sherlock 源代码
2. ✓ 解压文件
3. ✓ 安装 Python 依赖
4. ✓ 运行 Sherlock 搜索指定用户名
5. ✓ 将结果保存到 `output/` 目录

所有文件都保存在本地，**完全免费**！

---

## 故障排除

| 问题 | 解决方案 |
|------|--------|
| `command not found: bash` | 使用 `sh run_local.sh` 替代 |
| `ModuleNotFoundError: No module named 'sherlock'` | 尝试手动安装：`pip install sherlock` |
| 找不到 wget/unzip | 用包管理器安装：`apt-get install wget unzip` (Linux) 或 `brew install wget unzip` (macOS) |
| Python 版本过低 | 升级 Python 到 3.8 或更高版本 |

---

## 常见用法

```bash
# 搜索多个用户名
bash run_local.sh alice
bash run_local.sh bob

# 查看所有历史结果
ls output/

# 查看最新的结果
tail -n 100 output/sherlock_*_*.txt | head
```

---

## 其他说明

- 第一次运行会比较慢（需要下载和安装依赖）
- 后续运行会更快
- 所有结果都本地保存，不会上传到任何服务器
- 需要网络连接来下载 Sherlock 和搜索用户名

**有问题？直接修改 `run_local.sh` 或告诉我！** 🚀
