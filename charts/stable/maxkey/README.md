# maxkey

MaxKey单点登录认证系统，业界领先的IAM-IDaas身份管理和认证产品

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `maxkeytop/maxkey` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `2Gi` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| MYSQL_HOST | MaxKey数据库服务器地址 | `mysql` |
| MYSQL_PORT | MaxKey数据库服务器端口 | `3306` |
| MYSQL_DB | MaxKey数据库名称 | `maxkey` |
| MYSQL_USER | MaxKey数据库用户名 | `maxkey` |
| MYSQL_PASSWORD | MaxKey数据库密码 | `maxkey` |


## 安装方法

```bash
helm install my-release ./maxkey
```