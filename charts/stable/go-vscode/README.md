# Go VSCode

浏览器中运行的Go开发环境，集成VSCode编辑器和Go运行时。

## 描述

Go VSCode 是一个基于 code-server 的Go开发环境，提供了完整的Go开发体验。该镜像预装了Go 1.21、常用的Go开发工具（gopls、delve、goimports）以及优化的国内网络配置。

## 特性

- 🐹 Go 1.21 运行时环境
- 📝 VSCode编辑器界面
- 🛠️ 预装开发工具：gopls、delve、goimports
- 🌐 国内网络优化：GOPROXY、GOSUMDB配置
- 💾 持久化存储支持
- 🔐 密码保护访问
- 🌐 Web界面访问

## 配置说明

### 基础配置

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `image.repository` | 镜像名称 | `niehaoran/go-vscode` |
| `image.tag` | 镜像标签 | `latest` |
| `service.ports[0].port` | 服务端口 | `8080` |

### 环境变量

| 变量名 | 描述 | 默认值 |
|--------|------|--------|
| `CODE_SERVER_PASSWORD` | code-server访问密码 | `golang123` |
| `CODE_SERVER_PORT` | code-server运行端口 | `8080` |
| `GO111MODULE` | Go模块支持 | `on` |
| `GOPROXY` | Go代理设置 | `https://goproxy.cn,https://goproxy.io,direct` |
| `GOSUMDB` | Go校验数据库 | `sum.golang.google.cn` |
| `CGO_ENABLED` | CGO支持 | `0` |
| `GOOS` | 目标操作系统 | `linux` |
| `GOARCH` | 目标架构 | `amd64` |

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
| `resources.limits.cpu` | CPU限制 | `500m` |
| `resources.limits.memory` | 内存限制 | `1024Mi` |
| `resources.requests.cpu` | CPU请求 | `250m` |
| `resources.requests.memory` | 内存请求 | `512Mi` |

## 使用说明

> **⚠️ 重要提示**  
> 注意：请一定搭配应用路由来使用

1. 部署应用后，通过Web浏览器访问应用地址
2. 使用配置的密码登录（默认：`golang123`）
3. 在 `/app` 目录下创建和编辑Go代码
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