# nextcloud

Nextcloud 是一个安全的私有云存储和协作平台。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `nextcloud`   |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `20Gi`        |
| env                 | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量      | 描述                 | 默认值      |
|---------------|----------------------|------------|
| MYSQL_DATABASE| MySQL/MariaDB数据库名 | `nextcloud`|
| MYSQL_USER    | MySQL/MariaDB用户名   | `nextcloud`|
| MYSQL_PASSWORD| MySQL/MariaDB用户密码 | ``         |
| MYSQL_HOST    | MySQL/MariaDB主机地址 | ``         |

## 介绍
Nextcloud 是一个开源的、自托管的文件同步与共享平台。​

你可以把它想象成一个属于你自己的、可完全控制的“私有云盘”。核心功能包括：

​文件同步与共享：​ 像 Dropbox 一样在设备间同步文件，并方便地与他人共享文件或文件夹。
​在线协作：​ 内置文档编辑器（文字、表格、演示文稿）、日历、联系人、任务管理、实时聊天等工具，支持团队协作。
​数据控制：​ ​最关键的优势！​ 所有数据都存储在你自己的服务器上（无论是本地服务器、家庭 NAS 还是 VPS），保障隐私和安全，掌握数据主权。
​高度可扩展：​ 通过应用商店添加无数功能，如电子邮件客户端、项目管理、笔记、视频会议、密码管理等。
简单来说，Nextcloud 是一个功能强大且灵活的平台，让你能将文件、沟通和协作工具整合在 你掌控 的私有云环境中，是 Dropbox、Google Drive 或 Office 365 等商业云服务的一个有力开源替代品。​

核心要点总结
​开源免费：​ 核心功能免费使用。
​自托管：​ 数据存储在用户自己的服务器上。
​隐私安全：​ 用户完全控制数据。
​功能丰富：​ 超越网盘，集成多种办公协作工具。
​高度可定制：​ 通过应用扩展无限可能。