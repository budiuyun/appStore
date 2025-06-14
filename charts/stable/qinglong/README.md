# qinglong

Qinglong（青龙面板）是一款支持 Python3、JavaScript、Shell、Typescript 等多种脚本语言的定时任务管理平台，支持在线管理脚本、环境变量、配置文件，支持日志查看、系统通知、暗黑模式及移动端操作。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `whyour/qinglong` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web服务端口        | `5700`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `/ql/data`    |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

青龙面板的数据默认存储在容器的 `/ql/data` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| QlBaseUrl          | 自定义WEB访问路径          | `/`              |
| QlPort             | 自定义WEB服务端口          | `5700`           |

## 应用介绍

青龙面板是一款功能强大的定时任务管理平台，专为自动化脚本执行设计。它支持多种脚本语言，提供友好的Web界面进行管理，是自动化任务执行的理想选择。

主要功能包括：
- 多语言支持：支持Python3、JavaScript、Shell、Typescript等多种脚本语言
- 定时任务：支持crontab格式的定时任务配置
- 脚本管理：在线编辑、创建、导入和管理脚本
- 环境变量：集中管理脚本所需的环境变量
- 依赖管理：支持npm、pip等依赖安装
- 日志系统：详细记录任务执行情况和系统日志
- 系统通知：支持多种通知方式（如微信、Telegram、钉钉等）
- 用户界面：支持暗黑模式和移动端访问

青龙面板广泛应用于自动化签到、数据采集、监控预警、定时备份等场景，通过Web界面（5700端口）可以轻松管理所有自动化任务，提高工作效率。

项目主页：[https://github.com/whyour/qinglong](https://github.com/whyour/qinglong)