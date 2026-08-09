# Sherlock Runner (for Render)

这个仓库在容器启动时会下载 sherlock 的 master.zip 并在容器内运行一次（one-shot worker）。适合在 Render 上作为后台任务运行。

快速说明
- Dockerfile: 基础镜像为 python:3.11-slim，会安装 wget/unzip 并在容器启动时执行 /app/run.sh。
- run.sh: 下载并解压 sherlock master.zip，安装依赖并执行一次扫描。默认会使用环境变量 S_USERNAME 或容器启动时的第一个参数作为要查询的用户名。

使用示例（已为你预设用户名 daweiwei）

本地测试
1. 构建镜像：
   docker build -t sherlock-runner .
2. 运行一次（使用环境变量指定用户名 daweiwei）：
   docker run --rm -e S_USERNAME=daweiwei sherlock-runner
3. 或把用户名作为参数运行：
   docker run --rm sherlock-runner daweiwei
4. 将输出挂载到本地目录以便保存：
   mkdir -p ./output
   docker run --rm -v "$(pwd)/output":/app/output -e S_USERNAME=daweiwei sherlock-runner
5. 查看输出：
   ls -la ./output
   或在容器日志中查找 “Output saved to /app/output/sherlock_daweiwei_<TIMESTAMP>.txt”。

在 Render 上部署（一键导入）
1. 登录 https://render.com 并选择 New + -> Import from GitHub。
2. 选择仓库 `daweiwei555-bot/Zip`，Render 会读取仓库根目录下的 `render.yaml` 并创建一个 Worker 服务（sherlock-runner）。
3. 在服务的 Environment Variables 添加：
   - Name: S_USERNAME
   - Value: daweiwei
   或者把 Start Command 改为 `/app/run.sh daweiwei`。
4. 点击 Deploy。构建并运行完成后，在服务的 Logs 中查看运行输出。期望日志会包含：
   - [run.sh] Downloading sherlock master.zip...
   - [run.sh] Unzipping...
   - [run.sh] Installing python requirements (if any)...
   - [run.sh] Running sherlock for username: daweiwei
   - [run.sh] Output saved to /app/output/sherlock_daweiwei_<TIMESTAMP>.txt
   - === TAIL OF OUTPUT ===

注意
- Sherlock 的 CLI 入口可能会随 upstream 改动而改变；如果运行失败，请把容器日志贴给我，我会帮你调整 run.sh。
- Render 的 worker 是短暂容器，输出文件保存在容器内。如果需要持久化（例如上传到 S3 或存储到外部），告诉我想用的方式和凭证（或我可以添加上传到 S3 的示例，但不在代码中存放密钥）。

我已把 Dockerfile、run.sh、render.yaml 和 README.md 提交到仓库： https://github.com/daweiwei555-bot/Zip

下一步我会：
- 如果你想让我继续，我可以帮助你监控部署日志或根据日志修复问题；把部署后的日志贴给我即可.
