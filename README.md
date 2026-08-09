# 🔍 Sherlock Runner - Windows 本地版

> **用户名侦察工具**：在全球 300+ 社交媒体平台上搜索用户名，快速获取账户关联。

> ⚠️ 这是 **Sherlock 在 Windows 本地的运行版本**，不是 ZIP 压缩工具。

---

## 📌 项目说明

这是一个简化的 Sherlock 运行包，为 Windows 用户优化了执行流程。

- **用途**：社交媒体用户名搜索（本地侦察）
- **平台**：Windows 10/11 + Git Bash + Python 3.8+
- **特性**：
  - ✅ 一键启动（双击即用）
  - ✅ 支持自定义用户名
  - ✅ 结果保存到本地文件
  - ✅ 桌面快捷方式生成
  - ✅ 完全本地化，无需云服务

---

## 🚀 快速开始（3 步）

### 1️⃣ 安装依赖（5 分钟）

**Git Bash**（包含 bash/wget/unzip）
```
https://gitforwindows.org/
```

**Python 3.8+**（⚠️ 必须勾选 "Add Python to PATH"）
```
https://www.python.org/downloads/
```

**验证**
```cmd
bash --version
python --version
```

### 2️⃣ 克隆仓库

```cmd
git clone https://github.com/daweiwei555-bot/Zip.git
cd Zip
```

### 3️⃣ 运行

**方式 A：直接运行**
```cmd
Sherlock.bat
```

**方式 B：搜索特定用户名**
```cmd
Sherlock.bat alice
```

**方式 C：创建快捷方式（推荐）**
```cmd
create_desktop_shortcut.bat
# 然后双击桌面的 "ZIP" 快捷方式即可
```

---

## 📂 文件说明

### 主程序
| 文件 | 说明 |
|------|------|
| `Sherlock.bat` | 🎯 **主程序**（Windows 批处理） |
| `run_local.sh` | 实际执行脚本（Shell） |

### 设置脚本
| 文件 | 说明 |
|------|------|
| `create_desktop_shortcut.bat` | 创建/更新桌面快捷方式 |
| `create_desktop_shortcut.ps1` | PowerShell 辅助脚本 |
| `install.bat` | 一键完整安装（克隆 + 快捷方式） |

### 文档
| 文件 | 说明 |
|------|------|
| `QUICK_START.md` | ✨ **新手必看** - 快速开始指南 |
| `WINDOWS_SETUP.md` | 详细的 Windows 配置指南 |
| `LOCAL_SETUP.md` | 本地开发环境设置 |

### 输出
| 目录 | 说明 |
|------|------|
| `output/` | 搜索结果文件保存位置 |

---

## 📋 使用示例

### 示例 1：搜索用户名 "daweiwei"
```cmd
C:\Zip> Sherlock.bat daweiwei

╔═══════════════════════════════════════════════════════════╗
║           Sherlock 用户名搜索工具 - Windows 版            ║
╚═══════════════════════════════════════════════════════════╝

📝 搜索用户名: daweiwei
🚀 正在启动 Sherlock...

[*] Checking username on 300+ social media sites...
[+] Found on:
    ✓ GitHub: https://github.com/daweiwei
    ✓ Twitter: https://twitter.com/daweiwei
    ... 更多平台 ...

✓ 搜索完成，结果已保存
📂 结果保存在: C:\Zip\output\
```

### 示例 2：使用桌面快捷方式
```
1. 双击 create_desktop_shortcut.bat
2. 成功后，桌面出现 "ZIP" 快捷方式
3. 以后想搜索时，直接双击 "ZIP" 快捷方式即可
```

### 示例 3：一键完整安装
```cmd
install.bat

输出：
[1/4] 🔍 检查依赖...
✓ Git 已安装
✓ Python 已安装
✓ Git Bash 已安装

[2/4] ⬇️  克隆仓库到 D:\Zip...
✓ 仓库克隆完成

[3/4] 📋 检查文件...
✓ Sherlock.bat 已验证

[4/4] 🔗 创建桌面快捷方式...
✓ 快捷方式已创建

✓ 安装完成！
```

---

## 🎯 完整工作流

```
启动
  ↓
┌─────────────────────────────────────┐
│ Sherlock.bat [用户名]               │
└─────────────────────────────────────┘
  ↓
检查依赖（bash, python, git）
  ↓
启动 run_local.sh
  ↓
下载 Sherlock 项目（第一次）
  ↓
执行搜索（调用 Sherlock）
  ↓
300+ 社交媒体平台查询
  ↓
结果写入 output/ 文件
  ↓
显示完成消息
  ↓
用户按 Enter 关闭
```

---

## ⚡ 进阶用法

### 批量搜索多个用户名
创建 `batch_search.bat`：
```batchfile
@echo off
Sherlock.bat alice
Sherlock.bat bob
Sherlock.bat charlie
pause
```

双击运行，顺序搜索所有用户名。

### 自定义快捷方式参数
1. 右键桌面 "ZIP" 快捷方式 → 属性
2. "目标"字段末尾添加用户名：
   ```
   C:\Zip\Sherlock.bat alice
   ```
3. 确定，然后双击快捷方式

### 集成到 Windows 计划任务
定时自动搜索：
1. 打开 Windows 任务计划程序
2. 创建基本任务
3. 设置触发器（例如每天 20:00）
4. 操作选择 `Sherlock.bat`

---

## ✅ 环境检查清单

```cmd
# 1. 验证 Git Bash
C:\> bash --version
GNU bash, version 5.x.x ...    ✓

# 2. 验证 Python
C:\> python --version
Python 3.x.x                    ✓

# 3. 验证 Git
C:\> git --version
git version 2.x.x               ✓

# 4. 进入项目目录
C:\> cd Zip
C:\Zip> dir
Sherlock.bat
create_desktop_shortcut.bat
run_local.sh
output/
...                             ✓
```

---

## ⚠️ 常见问题

| 问题 | 解决方案 |
|------|---------|
| 双击后闪退 | 在 cmd 中运行 `Sherlock.bat` 查看错误信息 |
| 找不到 bash | 重新安装 Git Bash：https://gitforwindows.org/ |
| 找不到 Python | 重新安装 Python，勾选 "Add Python to PATH" |
| 运行很慢 | 正常！首次下载 Sherlock（5-10 分钟），后续快速 |
| 结果为空 | 检查用户名是否真实存在，或网络连接 |

详见 [QUICK_START.md](QUICK_START.md)

---

## 📊 输出格式

搜索完成后，结果保存在 `output/` 文件夹：

```
output/
├── sherlock_alice_2024-01-15_14-30-45.txt
├── sherlock_bob_2024-01-15_14-35-12.txt
└── sherlock_charlie_2024-01-15_14-40-33.txt
```

打开 `.txt` 文件查看完整结果（包含所有发现的账户链接）

---

## 🔐 隐私与安全

- ✅ **完全本地运行** - 无云服务，无账户系统
- ✅ **无数据上传** - 搜索结果只保存在本地
- ✅ **开源透明** - 代码完全可见，审计友好
- ✅ **免费使用** - 依赖 Sherlock 开源项目
- ✅ **离线可用** - 除初始下载外，可离线运行

---

## 🛠 故障排除

### 问题：提示缺少依赖
```cmd
# 1. 检查 bash
bash --version

# 2. 检查 python  
python --version

# 3. 重新安装缺失的工具
# 4. 重启电脑
```

### 问题：运行中断
```cmd
# 在 cmd 中重新运行，查看完整错误信息
cd Zip
Sherlock.bat alice
# 不要立即关闭窗口，仔细阅读错误提示
```

### 问题：结果文件为空
- 检查网络连接
- 确认用户名拼写正确
- 尝试其他已知用户名
- 查看窗口中的具体错误信息

---

## 📚 更多资源

- [Sherlock 原项目](https://github.com/sherlock-project/sherlock) - 主要的侦察工具
- [QUICK_START.md](QUICK_START.md) - 快速开始指南
- [WINDOWS_SETUP.md](WINDOWS_SETUP.md) - 详细配置文档
- [LOCAL_SETUP.md](LOCAL_SETUP.md) - 本地开发环境

---

## 📝 项目历史

这个仓库开始是一个简单的 Sherlock 包装器，用于：
- ✅ 简化 Windows 用户的安装和使用
- ✅ 提供友好的 GUI 入口
- ✅ 生成桌面快捷方式
- ✅ 规范化本地执行流程

---

## 📄 许可证

本项目采用原 Sherlock 项目的许可证（MIT）。

---

## 💬 反馈

如果你有问题或建议：
1. 检查 [QUICK_START.md](QUICK_START.md) 和常见问题
2. 查看错误日志（在 cmd 窗口中运行）
3. 提交 Issue 或讨论

---

**开始搜索吧！🔍** 双击 `Sherlock.bat` 或 `create_desktop_shortcut.bat`
