# Lsky Pro

官方Lsky Pro图床服务Chart，提供便捷的图片上传与管理系统。

## 应用介绍

本应用提供以下功能：
- Lsky Pro 图床服务：开源的图片上传和管理系统
- 支持多种上传方式：本地上传、URL导入、拖拽上传等
- 批量上传、图片预览、远程下载、自定义水印等功能
- 基于PHP后端和Vue.js前端的简洁美观界面
- 支持持久化存储：确保图片数据安全

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.imageRegistry | 镜像仓库地址 | `docker.1ms.run` |
| image.repository | 镜像名称 | `coldpig/lskypro-docker` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.webport | Web服务端口 | `80` |
| networkLimits.enabled | 是否启用网络带宽限制 | `true` |
| networkLimits.egress | 出站带宽限制 | `1M` |
| networkLimits.ingress | 入站带宽限制 | `1M` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.path | 持久化存储路径 | `/var/www/html` |
| persistence.accessMode | 存储访问模式 | `ReadWriteOnce` |
| persistence.size | 存储大小 | `5Gi` |
| persistence.storageClass | 存储类 | `local` |

### 资源配置
```yaml
resources:
  limits:
    cpu: 200m
    memory: 512Mi
  requests:
    cpu: 50m
    memory: 128Mi
```

### 环境变量配置
应用预设了以下环境变量用于配置数据库连接：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| DB_CONNECTION | MySQL数据库连接类型 | `mysql` |
| DB_HOST | MySQL数据库服务器主机名 | `127.0.0.1` |
| DB_PORT | MySQL数据库连接端口 | `3306` |
| DB_DATABASE | LskyPro使用的数据库名 | `lskypro` |
| DB_USERNAME | 连接数据库的用户名 | `root` |
| DB_PASSWORD | 连接数据库的密码 | `MyPassword` |

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 数据存储

Lsky Pro中的图片和数据默认存储在容器的 `/var/www/html` 目录中，启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失图片和用户数据。

**提示**：请根据预计存储的图片数量，确保分配足够的存储空间，生产环境建议至少 5Gi。

## 使用说明

1. 部署应用后，可通过服务的地址访问Lsky Pro管理界面
2. 首次访问时，按照界面提示完成初始化配置
3. 配置完成后，可以开始上传和管理图片

## 数据库配置

Lsky Pro需要MySQL数据库才能正常运行，您有两种选择：
1. 使用环境变量指向现有的MySQL服务
2. 通过Helm部署一个MySQL实例，然后配置Lsky Pro连接到它

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用更严格的网络访问控制
- 定期备份图片和数据
- 配置适当的资源限制，防止资源滥用
- 避免使用默认的数据库凭据

## 故障排除

1. 无法访问管理界面：
   - 检查服务是否正常运行
   - 确认网络连接是否畅通
   - 检查容器日志
2. 持久化问题：
   - 确认PVC已正确创建并绑定
   - 检查存储类是否可用
   - 验证存储容量是否足够
3. 数据库连接问题：
   - 确认数据库服务运行正常
   - 验证数据库连接参数是否正确
   - 检查网络策略是否允许应用访问数据库

## 安装方法

```bash
helm install my-release ./Lsky Pro
```

