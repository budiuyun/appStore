# Go VSCode

浏览器中运行的Go开发环境，集成VSCode编辑器和Go运行时。

## 描述

Go VSCode 是一个基于 code-server 的Go开发环境，使用官方扩展的 `ghcr.io/frost-tb-voo/code-server-go` 镜像，提供了完整的Go开发体验。该镜像预装了最新版Go、vscode-go扩展以及完整的开发工具链。

## 特性

- 🐹 最新版Go运行时环境
- 📝 VSCode编辑器界面
- 🛠️ 预装vscode-go扩展和开发工具
- 🌐 国内网络优化：GOPROXY、GOSUMDB配置
- 💾 持久化存储支持（项目、配置、扩展）
- 🔐 密码保护访问
- 🌐 Web界面访问
- 🚀 基于官方维护的专业Go开发镜像

## 配置说明

### 基础配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `image.repository` | 镜像名称 | `ghcr.io/frost-tb-voo/code-server-go` |
| `image.tag` | 镜像标签 | `latest` |
| `service.ports[0].port` | 服务端口 | `8080` |

### 环境变量

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| `PASSWORD` | code-server访问密码 | `golang123` |
| `SUDO_PASSWORD` | sudo访问密码 | `golang123` |
| `GO111MODULE` | Go模块支持 | `on` |
| `GOPROXY` | Go代理设置 | `https://goproxy.cn,https://goproxy.io,direct` |
| `GOSUMDB` | Go校验数据库 | `sum.golang.google.cn` |
| `GOPATH` | Go工作空间路径 | `/home/coder/go` |

### 存储配置

默认启用持久化存储，挂载Go开发相关目录到持久卷。

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `persistence.enabled` | 启用持久化存储 | `true` |
| `persistence.size` | 存储大小 | `2Gi` |
| `persistence.mounts` | 挂载路径 | `/home/coder/project`, `/home/coder`, `/home/coder/go`, `/home/coder/.local/share/code-server` |

### 资源配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `resources.limits.cpu` | CPU限制 | `500m` |
| `resources.limits.memory` | 内存限制 | `1024Mi` |
| `resources.requests.cpu` | CPU请求 | `250m` |
| `resources.requests.memory` | 内存请求 | `512Mi` |

## 使用说明

> **⚠️ 重要提示**  
> 注意：请一定搭配应用路由来使用

1. 部署应用后，通过Web浏览器访问应用地址
2. 使用配置的密码登录（默认：`golang123`）
3. 在 `/home/coder/project` 目录下创建和编辑Go代码
4. 使用内置终端运行Go程序

## 预装工具

- **Go 1.21**: 最新的Go运行时
- **code-server**: Web版VSCode编辑器
- **开发工具**:
  - gopls: Go语言服务器
  - delve (dlv): Go调试器
  - goimports: 导入管理工具
- **网络优化**:
  - 国内GOPROXY代理配置
  - 优化的GOSUMDB设置

## 开发环境特性

### Go环境配置
- 支持Go Modules
- 预配置国内代理，加速包下载
- 静态编译配置（CGO_ENABLED=0）
- Linux/amd64目标平台

### 开发工具集成
- **语言服务器**: gopls提供智能代码补全、跳转定义等功能
- **调试支持**: delve调试器支持断点调试
- **代码格式化**: 自动导入管理和代码格式化

### 工作流程
1. 在 `/app` 目录创建Go项目
2. 使用 `go mod init` 初始化模块
3. 编写Go代码，享受IDE功能
4. 使用内置终端运行 `go run`、`go build`、`go test`

## 镜像信息

基于 `niehaoran/go-vscode:latest` 镜像构建，该镜像包含：

- Go 1.21-bullseye 基础镜像
- code-server Web编辑器
- 预装Go开发工具
- 国内网络优化配置
- 非root用户运行（developer用户）

## 示例项目

创建一个简单的Hello World项目：

```bash
# 在终端中执行
cd /app
mkdir hello-world
cd hello-world
go mod init hello-world

# 创建main.go文件
echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello, Go World!")
}' > main.go

# 运行程序
go run main.go
``` 