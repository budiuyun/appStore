# alist

AList 是一个支持多种存储的文件列表程序，基于 Gin 和 React（Solidjs）开发。它可以将本地存储、各类云盘、对象存储等多种后端统一展示为可浏览、可分享的文件列表，适合个人和团队搭建自有的文件管理与分享平台。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `xhofe/alist` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.http  | 服务端口           | `5244`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `/opt/alist/data` |
| env                | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述                       | 默认值 |
|----------|----------------------------|--------|
| PUID     | 容器内运行进程的用户UID     | `0`    |
| PGID     | 容器内运行进程的用户GID     | `0`    |
| UMASK    | 新建文件的权限掩码         | `022`  |

## 数据存储

AList 的数据默认存储在容器的 `/opt/alist/data` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 1Gi。

## 应用介绍

AList 支持多种主流云存储和本地存储的接入，提供统一的 Web 管理界面和 API，便于文件的浏览、上传、下载和分享。适用于个人网盘、团队文件共享、公开文件列表等多种场景。  
项目主页及文档：[https://alist.nn.ci/](https://alist.nn.ci/)