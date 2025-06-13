# minio

MinIO 是一个高性能的多云对象存储服务，兼容 Amazon S3 API，适用于机器学习、分析和应用数据等多种场景。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `minio/minio` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.api   | API服务端口        | `9000`        |
| service.ports.console | 控制台端口       | `9001`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `10Gi`        |
| persistence.mounts  | 挂载路径           | `/data`       |
| env                | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| MINIO_ROOT_USER    | MinIO 管理员用户名         | `minioadmin`     |
| MINIO_ROOT_PASSWORD| MinIO 管理员密码           | `minioadmin`     |
| MINIO_SERVER_URL   | MinIO 服务外部访问URL      | ``               |
| MINIO_BROWSER_REDIRECT_URL | 控制台重定向URL      | ``               |

## 数据存储

MinIO 的数据默认存储在容器的 `/data` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 10Gi。

## 应用介绍

MinIO 提供高性能、可扩展的对象存储服务，兼容 S3 API，适用于私有云、公有云和混合云环境。支持通过 Web 控制台（9001端口）进行管理，也可通过 S3 协议与各类客户端和SDK集成。适合机器学习、备份、归档、数据湖等多种场景。

项目主页及文档：[https://min.io/](https://min.io/)
