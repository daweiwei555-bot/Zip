# Windows 快速启动指南

## 📋 前置要求

在运行之前，请确保你已安装以下软件（都是免费的）：

### 1️⃣ **Git Bash** (包含 bash, wget, unzip)
- 下载：https://gitforwindows.org/
- 安装时选择默认选项即可
- 验证：打开 cmd 输入 `bash --version`

### 2️⃣ **Python 3.8+**
- 下载：https://www.python.org/downloads/
- **重要**：安装时勾选 ✅ "Add Python to PATH"
- 验证：打开 cmd 输入 `python --version`

---

## 🚀 使用方法

### 第一次设置（一次性）

1. **克隆或下载仓库**
   ```
   git clone https://github.com/daweiwei555-bot/Zip.git
   cd Zip
   ```

2. **运行 `Sherlock.bat`**
   - 直接双击 `Sherlock.bat` 文件
   - 或在文件夹中右键选择"用 cmd 运行"

### 快速运行方式

**方式 A：使用默认用户名 (daweiwei)**
```bash
双击 Sherlock.bat
```

**方式 B：搜索自定义用户名**
```bash
右键点击 Sherlock.bat → 发送到 → 桌面（快捷方式）
然后右键快捷方式 → 属性
在"目标"最后加上用户名，例如：
D:\Zip\Sherlock.bat alice

点击确定，然后双击快捷方式运行
```

或者在 cmd/PowerShell 中运行：
```cmd
Sherlock.bat alice
Sherlock.bat bob
```

---

## 📂 查看结果

运行完成后，结果会保存在：
```
Zip\output\sherlock_用户名_时间戳.txt
```

**查看结果：**
- 打开 `Zip` 文件夹
- 进入 `output` 文件夹
- 用记事本打开 `.txt` 文件即可

---

## ⚠️ 常见问题

### ❌ 双击后没有反应
- 检查是否安装了 Git Bash
- 在 cmd 中运行看看是否有错误信息

### ❌ 提示"找不到 bash"
- 重新安装 Git Bash
- 安装完后重启电脑

### ❌ 提示"找不到 Python"
- 重新安装 Python，**必须勾选 "Add Python to PATH"**
- 安装完后重启电脑

### ❌ 运行很慢
- 第一次运行需要下载 Sherlock (~5-10分钟)，耐心等待
- 后续运行会快很多

### ❌ 结果文件为空或错误
- 检查网络连接
- 用户名可能在该社交平台不存在
- 查看窗口中的错误提示

---

## 🎯 完整工作流

```
1. 双击 Sherlock.bat
   ↓
2. 等待下载依赖（首次较慢）
   ↓
3. 脚本自动搜索用户名
   ↓
4. 结果保存到 output\ 文件夹
   ↓
5. 按 Enter 关闭窗口
   ↓
6. 打开 output\ 查看结果
```

---

## 💡 提示

- **每次运行都是独立的**，不会互相干扰
- **所有操作都是本地的**，完全免费，无需网络（除了下载和查询时）
- **可以设置 Windows 计划任务** 定时运行（高级用法）

---

有问题？检查一下是否都安装好了！🎉
