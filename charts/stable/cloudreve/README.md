# cloudreve

Cloudreve 是一款支持多家云存储的自托管云盘系统，支持本地和多种主流云存储，具备丰富的文件管理与分享功能。适合个人和团队搭建私有云盘，实现统一的多云存储管理与文件协作。

## 主要特性

- 支持本地存储、七牛云、阿里云OSS、腾讯云COS、又拍云、OneDrive、S3兼容存储等多种后端
- 多用户、多分组管理，适合团队协作
- 文件/文件夹上传、下载、批量操作、压缩/解压、拖拽管理
- 创建带有效期的分享链接
- 支持在线视频、图片、音频、文本、Office文档、ePub等多种格式的在线预览
- WebDAV 支持，所有存储后端均可通过 WebDAV 协议挂载
- 可集成 Aria2 实现离线下载和多节点分流
- 支持上传/下载限速，保障带宽分配
- 支持自定义主题色、暗色模式、PWA应用、国际化
- 一体化部署，开箱即用

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `cloudreve/cloudreve` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.http  | 服务端口           | `5212`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `10Gi`        |
| persistence.mounts  | 挂载路径           | `/cloudreve/uploads`, `/cloudreve/config`, `/cloudreve/db` |
| env                | 环境变量配置       | 见下文        |

## 环境变量

| 环境变量 | 描述                       | 默认值 |
|----------|----------------------------|--------|
| PUID     | 容器内运行进程的用户UID     | `0`    |
| PGID     | 容器内运行进程的用户GID     | `0`    |

## 数据存储

- `/cloudreve/uploads`：用户上传文件存储目录
- `/cloudreve/config`：配置文件目录
- `/cloudreve/db`：数据库文件目录

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 10Gi。

## 应用介绍

Cloudreve 致力于为用户提供统一的多云存储管理体验，支持丰富的文件操作、分享与预览功能，适合个人网盘、团队文件共享、公开文件列表等多种场景。  
项目主页及文档：[https://cloudreve.org/](https://cloudreve.org/)  
演示站点：[https://demo.cloudreve.org/](https://demo.cloudreve.org/)