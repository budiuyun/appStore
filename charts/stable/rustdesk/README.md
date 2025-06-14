# rustdesk

RustDesk 是一款全功能开源远程桌面控制软件，支持自托管和安全访问，配置简单，适合个人和企业远程运维、桌面协作等场景。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `linuxserver/rustdesk` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.http  | HTTP服务端口       | `3000`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `2Gi`         |
| persistence.mounts  | 挂载路径           | `/config`     |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

RustDesk 的配置数据默认存储在容器的 `/config` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| PUID               | 容器内运行用户的UID        | `1000`           |
| PGID               | 容器内运行用户的GID        | `1000`           |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |
| CUSTOM_USER        | WEB界面HTTP Basic认证用户名 | `abc`            |
| PASSWORD           | WEB界面HTTP Basic认证密码   | `abc`            |

## 应用介绍

RustDesk 是一款开源的远程桌面控制软件，使用 Rust 语言编写，提供了类似于 TeamViewer 和 AnyDesk 的功能，但完全开源且支持自托管服务器。它允许用户远程控制其他计算机，无需复杂的网络配置。

主要功能包括：
- 远程控制：完全控制远程计算机的桌面
- 文件传输：在本地和远程计算机之间传输文件
- 跨平台支持：支持 Windows、macOS、Linux、Android、iOS 等多种平台
- 自托管服务器：可以部署自己的中继服务器，保证数据隐私
- 安全连接：使用端到端加密保护连接安全
- 低延迟：优化的协议和编码，提供流畅的远程控制体验
- 无需安装：客户端支持便携式使用，无需安装
- 会话录制：支持记录远程会话
- 多显示器支持：支持多显示器环境

RustDesk 适用于远程技术支持、远程办公、远程教育等多种场景，是一个安全、高效的远程桌面解决方案。通过Web界面（3000端口）可以管理服务器设置和连接状态。

项目主页：[https://rustdesk.com/](https://rustdesk.com/)