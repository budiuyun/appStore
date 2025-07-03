# New API

AI模型接口管理与分发系统，用于管理和分发AI模型接口。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- 使用Deployment确保应用程序可以稳定运行并支持滚动更新

## 参数

| 参数                | 描述               | 默认值         |
|---|-----|---|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `calciumion/new-api`   |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.http.port | HTTP端口      | `3000`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `/data`       |
| env                 | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量      | 描述                 | 默认值      |
|---|----|---|
| SQL_DSN       | MySQL数据库连接字符串 | `用户名:密码@tcp(数据库地址:3306)/数据库名` |
| TZ            | 容器的时区设置        | `Asia/Shanghai` |

## 介绍
New API是一个功能强大的AI模型接口管理与分发系统，提供以下功能：
- AI模型接口统一管理
- 接口调用权限控制
- 用量统计与限制
- 多渠道接口分发
- 负载均衡与调度

通过New API，用户可以方便地管理各种AI模型接口，实现接口的统一调用和分发，大大简化了AI应用的开发和部署流程。

## 使用说明
安装完成后，可通过以下步骤开始使用：
1. 访问服务端口(3000)进入Web管理界面
2. 配置数据库连接信息(SQL_DSN环境变量)
3. 登录系统并开始添加和管理AI模型接口
4. 创建API密钥，分配给应用程序使用

注意事项：
- 首次使用需要正确配置数据库连接信息
- 建议为重要数据设置定期备份
- 可根据实际需求调整资源限制和存储大小