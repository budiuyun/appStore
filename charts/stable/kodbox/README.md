# kodbox

kodbox（可道云）是一款企业级私有云盘系统，支持多种云存储和本地存储，具备多用户管理、文件管理、在线预览、分享、权限控制等丰富功能。适合企业、团队和个人搭建自有云盘，实现文件的集中管理与协作。

## 主要特性

- 多存储支持：本地存储、七牛云、阿里云OSS、腾讯云COS、又拍云、OneDrive、S3兼容存储等。
- 多用户与权限管理：支持多用户、多分组、细粒度权限控制，适合团队协作。
- 文件管理与分享：支持文件/文件夹上传、下载、批量操作、压缩/解压、拖拽管理、创建带有效期的分享链接。
- 在线预览：支持图片、音频、视频、Office文档、ePub等多种格式的在线预览。
- WebDAV 支持：可通过 WebDAV 协议挂载。
- 一体化部署：所有功能开箱即用，支持Docker Compose一键部署数据库和Redis。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `kodcloud/kodbox` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.http  | HTTP服务端口       | `80`          |
| service.ports.https | HTTPS服务端口      | `443`         |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `10Gi`        |
| persistence.mounts  | 挂载路径           | `/var/www/html`, `/etc/nginx/ssl` |
| env                | 环境变量配置       | 见下文        |

## 环境变量

只需配置以下数据库相关环境变量即可完成自动化部署：

| 环境变量      | 描述                 | 默认值      |
|---------------|----------------------|------------|
| MYSQL_DATABASE| MySQL/MariaDB数据库名 | `kodbox`   |
| MYSQL_USER    | MySQL/MariaDB用户名   | `kodbox`   |
| MYSQL_PASSWORD| MySQL/MariaDB用户密码 |            |
| MYSQL_HOST    | MySQL/MariaDB主机地址 |            |
| MYSQL_PORT    | MySQL/MariaDB端口     | `3306`     |

## 数据存储

- `/var/www/html`：站点数据和用户文件目录
- `/etc/nginx/ssl`：SSL证书目录（如需HTTPS）

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 10Gi。

## 应用介绍

kodbox 致力于为用户提供统一的多云存储管理体验，支持丰富的文件操作、分享与预览功能，适合企业网盘、团队文件共享、公开文件列表等多种场景。  
项目主页及文档：[https://kodcloud.com/](https://kodcloud.com/)  
官方镜像仓库：[https://hub.docker.com/r/kodcloud/kodbox](https://hub.docker.com/r/kodcloud/kodbox)