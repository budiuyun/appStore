# Uptime Kuma

Uptime Kuma 是一个开源、轻量的自托管监控工具，支持对网站、服务器和 API 的正常运行时间进行实时监控，帮助用户快速了解服务的运行状况。它提供友好的用户界面、支持多种通知方式（如邮件、Telegram、Slack 等）以及历史记录追踪功能。

## 应用介绍

本应用提供以下功能：
- 实时监控：支持对网站、服务器和API进行监控
- 多种通知方式：支持邮件、Telegram、Discord、Slack等90多种通知服务
- 友好的用户界面：简洁直观的监控面板
- 历史记录追踪：记录服务状态变化
- 支持持久化存储：确保数据安全
- 轻量级部署：资源占用少

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `louislam/uptime-kuma` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.port | 服务端口 | `3001` |
| networkLimits.enabled | 启用网络带宽限制 | `true` |
| networkLimits.egress | 出站带宽限制 | `1M` |
| networkLimits.ingress | 入站带宽限制 | `1M` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `1Gi` |
| persistence.path | 数据挂载路径 | `/app/data` |
| persistence.accessMode | 存储访问模式 | `ReadWriteOnce` |
| persistence.storageClass | 存储类 | `local` |

### 资源配置
- CPU限制: 128m（相当于0.128核心）
- 内存限制: 256Mi（相当于256兆字节）
- CPU请求: 64m（相当于0.064核心）
- 内存请求: 128Mi（相当于128兆字节）

### 环境变量配置

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| NODE_ENV | 应用运行的模式 | `production` |
| KUMA_DEBUG | 是否开启调试模式 | `false` |

## 数据存储

Uptime Kuma 数据默认存储在容器的 `/app/data` 目录中。启用持久化存储后，监控数据将保存在持久卷中，即使容器重启也不会丢失历史监控记录。

**提示**：如果您计划监控大量站点或长期保存历史记录，请考虑增加存储空间。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：
   - 通过浏览器访问服务的3001端口

2. 首次访问：
   - 创建管理员账户
   - 添加要监控的站点或服务
   - 配置通知方式

3. 添加监控项：
   - 在界面中点击"添加监控"
   - 输入站点URL或服务IP
   - 选择监控类型（HTTP、TCP、Ping等）
   - 设置检查间隔时间
   - 配置通知规则

## 监控特性

Uptime Kuma 支持多种监控类型：
- HTTP/HTTPS 网站监控
- TCP端口监控
- Ping监控
- DNS监控
- 数据库连接监控
- 证书有效期监控

## 安全注意事项

- 首次设置时创建强密码
- 考虑启用2FA双因素认证
- 使用反向代理进行访问控制
- 定期备份监控数据
- 配置适当的资源限制

## 故障排除

1. 无法访问Uptime Kuma界面：
   - 检查服务是否正常运行
   - 确认网络连接和端口配置
   - 检查容器日志

2. 持久化问题：
   - 确认PVC已正确创建并绑定
   - 检查存储类是否可用
   - 验证存储容量是否足够

3. 监控警报无法发送：
   - 检查通知服务配置
   - 验证网络连接
   - 检查日志中的错误信息