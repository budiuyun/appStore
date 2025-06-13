# nextcloud

Nextcloud 是一个安全的私有云存储和协作平台。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `nextcloud` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `20Gi` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| MYSQL_DATABASE | MySQL/MariaDB数据库名 | `nextcloud` |
| MYSQL_USER | MySQL/MariaDB用户名 | `nextcloud` |
| MYSQL_PASSWORD | MySQL/MariaDB用户密码 | `` |
| MYSQL_HOST | MySQL/MariaDB主机地址 | `` |


## 安装方法

```bash
helm install my-release ./nextcloud
```