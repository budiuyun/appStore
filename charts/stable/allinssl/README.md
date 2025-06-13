# allinssl

开源免费的 SSL 证书自动化管理平台，集证书申请、管理、部署和监控于一体，支持多平台自动化部署和站点证书监控。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `allinssl/allinssl` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web服务端口        | `8888`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `/www/allinssl/data` |
| env                | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| ALLINSSL_USER      | WEB登录用户名              | `allinssl`       |
| ALLINSSL_PWD       | WEB登录密码                | `allinssldocker` |
| ALLINSSL_URL       | 自定义WEB访问路径          | `allinssl`       |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 数据存储

AllInSSL 的数据默认存储在容器的 `/www/allinssl/data` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

AllInSSL 是一款开源免费的 SSL 证书自动化管理平台，集证书申请、管理、部署和监控于一体。支持多种证书颁发机构，可自动申请、续期和部署 SSL 证书，提供证书到期提醒和健康监控功能。适用于需要管理多个站点 SSL 证书的个人和企业用户，大幅降低证书管理的运维成本。

通过 Web 界面（8888端口）可以轻松管理所有证书，支持一键申请、自动部署和批量操作，让 SSL 证书管理变得简单高效。