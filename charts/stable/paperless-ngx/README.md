# paperless-ngx

Paperless-ngx 是一款开源文档管理系统，支持扫描件归档、全文检索、标签分类、元数据管理等功能，适合个人和企业实现无纸化办公。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `linuxserver/paperless-ngx` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web服务端口        | `8000`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `5Gi`         |
| persistence.mounts  | 挂载路径           | 见下文        |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

Paperless-ngx 的数据默认挂载在以下路径：
- `/config` - 应用配置
- `/data` - 文档数据

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐至少 5Gi 以存储文档和索引。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| PUID               | 容器内运行用户的UID        | `1000`           |
| PGID               | 容器内运行用户的GID        | `1000`           |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |
| REDIS_URL          | 外部Redis实例地址          | ``               |

## 应用介绍

Paperless-ngx 是一款现代化的文档管理系统，专为无纸化办公设计。它能够自动处理、分类和存储各种文档，包括扫描的纸质文档、PDF文件、电子账单等，并提供强大的全文搜索功能，让您能够轻松找到需要的任何文件。

主要功能包括：
- 文档扫描与导入：支持多种方式导入文档，包括扫描仪、邮件、网页上传等
- OCR文本识别：自动对文档进行OCR处理，提取文本内容
- 全文检索：强大的搜索功能，可以根据内容、标签、日期等多种条件查找文档
- 自动分类：基于规则的自动文档分类和标签系统
- 元数据管理：支持添加和管理文档元数据，如日期、对应方、类型等
- 文档预览：内置文档查看器，支持在线预览各种格式的文档
- 安全存储：所有文档安全加密存储，支持用户权限管理

通过Web界面（8000端口）可以轻松管理所有文档，支持移动端访问，是个人和企业实现无纸化办公的理想选择。

项目主页：[https://paperless-ngx.readthedocs.io/](https://paperless-ngx.readthedocs.io/)