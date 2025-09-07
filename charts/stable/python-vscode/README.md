# Python VSCode

浏览器中运行的Python开发环境，集成VSCode编辑器和Python运行时。

## 描述

Python VSCode 是一个基于 code-server 的Python开发环境，提供了完整的Python开发体验。该镜像预装了Python 3.11、常用的Python开发工具（black、flake8、mypy、pytest）以及常用库（requests、numpy、pandas）。

## 特性

- 🐍 Python 3.11 运行时环境
- 📝 VSCode编辑器界面
- 🛠️ 预装开发工具：black、flake8、mypy、pytest
- 📚 预装常用库：requests、numpy、pandas
- 💾 持久化存储支持
- 🔐 密码保护访问
- 🌐 Web界面访问

## 配置说明

### 基础配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `image.repository` | 镜像名称 | `niehaoran/python-vscode` |
| `image.tag` | 镜像标签 | `latest` |
| `service.ports[0].port` | 服务端口 | `8080` |

### 环境变量

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| `CODE_SERVER_PASSWORD` | code-server访问密码 | `python123` |
| `CODE_SERVER_PORT` | code-server运行端口 | `8080` |
| `PYTHONUNBUFFERED` | Python输出无缓冲 | `1` |

### 存储配置

默认启用持久化存储，将 `/app` 目录挂载到持久卷。

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `persistence.enabled` | 启用持久化存储 | `true` |
| `persistence.size` | 存储大小 | `10Gi` |
| `persistence.mounts[0]` | 挂载路径 | `/app` |

### 资源配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `resources.limits.cpu` | CPU限制 | `1000m` |
| `resources.limits.memory` | 内存限制 | `2Gi` |
| `resources.requests.cpu` | CPU请求 | `500m` |
| `resources.requests.memory` | 内存请求 | `1Gi` |

## 使用说明

1. 部署应用后，通过Web浏览器访问应用地址
2. 使用配置的密码登录（默认：`python123`）
3. 在 `/app` 目录下创建和编辑Python代码
4. 使用内置终端运行Python程序

## 预装工具

- **Python 3.11**: 最新的Python运行时
- **code-server**: Web版VSCode编辑器
- **开发工具**:
  - black: 代码格式化
  - flake8: 代码检查
  - mypy: 类型检查
  - pytest: 单元测试
- **常用库**:
  - requests: HTTP库
  - numpy: 数值计算
  - pandas: 数据处理

## 镜像信息

基于 `niehaoran/python-vscode:latest` 镜像构建，该镜像包含：

- Python 3.11-slim 基础镜像
- code-server Web编辑器
- 预装开发工具和常用库
- 非root用户运行（developer用户） 