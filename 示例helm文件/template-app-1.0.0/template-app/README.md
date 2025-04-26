# Template App

这是一个完整的模板应用，用于帮助您快速创建符合规范的 Helm Chart。本文档包含详细说明和示例，帮助您理解每个部分的作用和配置方法。

## 快速入门指南

如果您希望快速上手创建自己的应用，可以按照以下步骤操作：

### 1. 配置基本信息

复制模板目录，并修改`Chart.yaml`中的基本信息：

```bash
cp -r charts/stable/template-app-1.0.0 charts/stable/your-app-1.0.0
mv charts/stable/your-app-1.0.0/template-app charts/stable/your-app-1.0.0/your-app
```

### 2. 修改 values.yaml 关键配置

打开`values.yaml`，重点修改以下部分：

```yaml
# 镜像配置
image:
  imageRegistry: "registry-2.yunna.net" # 保持不变
  repository: your/application # 修改为您的应用镜像名称
  tag: "1.0.0" # 修改为您的应用版本

# 服务端口配置
service:
  port: 8080 # 修改为您的应用服务端口

# 资源配置
resources:
  limits:
    cpu: 500m # 根据应用需求调整
    memory: 512Mi

# 持久化配置
persistence:
  size: 5Gi # 根据应用需要的存储空间调整
```

### 3. 添加环境变量

在`values.yaml`中添加应用所需的环境变量：

```yaml
env:
  db_config:
    name: "DATABASE_URL"
    value: "postgres://user:pass@db:5432/mydb"
  app_config:
    name: "LOG_LEVEL"
    value: "info"
```

同时，在`values.schema.json`中确保这些环境变量有正确的定义：

```json
"env": {
  "type": "object",
  "properties": {
    "db_config": {
      "type": "object",
      "properties": {
        "name": { "type": "string" },
        "value": { "type": "string" }
      }
    },
    "app_config": {
      "type": "object",
      "properties": {
        "name": { "type": "string" },
        "value": { "type": "string" }
      }
    }
  }
}
```

> 注意：values.schema.json 中的 patternProperties 已经允许任意命名的环境变量，通常不需要额外修改。

### 4. 确保端口一致性

确保`deployment.yaml`和`service.yaml`中的端口配置一致：

1. 修改`deployment.yaml`中的 containerPort：

   ```yaml
   ports:
     - name: http
       containerPort: 8080 # 与您的应用实际端口一致
       protocol: TCP
   ```

2. 修改`service.yaml`中的 targetPort，确保与 containerPort 匹配：
   ```yaml
   ports:
     - port: { { .Values.service.port } }
       targetPort: 8080 # 必须与deployment.yaml中的containerPort相同
       protocol: TCP
   ```

### 5. 配置持久化挂载路径

1. 确定您的应用数据存储路径，修改`deployment.yaml`中的挂载路径：

   ```yaml
   volumeMounts:
     - name: data
       mountPath: /your/app/data/path # 修改为应用实际数据目录
   ```

2. 修改 README.md 中的数据存储说明：

   ```markdown
   ## 数据存储

   应用数据存储在容器的 `/your/app/data/path` 目录中。
   ```

### 6. 验证您的配置

```bash
# 验证Chart格式是否正确
helm lint charts/stable/your-app-1.0.0/your-app

# 生成模板并检查
helm template charts/stable/your-app-1.0.0/your-app > generated.yaml
```

查看`generated.yaml`文件，确认配置是否符合预期。

## 应用简介

此模板应用演示了一个标准的 Web 应用部署结构，包括：

- 应用部署配置
- 服务暴露
- 持久化存储
- 网络带宽限制

您可以基于此模板，根据自己的应用需求进行修改，创建满足您需求的 Helm Chart。

## 快速开始

### 使用此模板创建新应用

1. 复制此模板目录到新位置：

```bash
cp -r charts/stable/template-app-1.0.0 charts/stable/你的应用名-版本号
```

2. 重命名应用目录：

```bash
mv charts/stable/你的应用名-版本号/template-app charts/stable/你的应用名-版本号/你的应用名
```

3. 修改 Chart.yaml 中的基本信息，包括 name, version, description 等

4. 根据您的应用需求修改 values.yaml 和模板文件

5. 本地测试您的 Chart：

```bash
helm lint charts/stable/你的应用名-版本号/你的应用名
helm template charts/stable/你的应用名-版本号/你的应用名
```

### 安装方法

使用以下命令安装此应用：

```bash
helm install my-release charts/stable/template-app-1.0.0/template-app
```

## 配置参数说明

下表列出了 Template App 的可配置参数及其默认值：

| 参数                        | 描述                 | 默认值                 |
| --------------------------- | -------------------- | ---------------------- |
| `replicaCount`              | 应用副本数           | `1`                    |
| `image.imageRegistry`       | 镜像仓库地址         | `registry-2.yunna.net` |
| `image.repository`          | 镜像名称             | `template/app`         |
| `image.tag`                 | 镜像标签             | `latest`               |
| `image.pullPolicy`          | 镜像拉取策略         | `IfNotPresent`         |
| `service.type`              | 服务类型             | `ClusterIP`            |
| `service.port`              | 服务端口             | `80`                   |
| `networkLimits.enabled`     | 是否启用网络带宽限制 | `true`                 |
| `networkLimits.egress`      | 出站带宽限制         | `1M`                   |
| `networkLimits.ingress`     | 入站带宽限制         | `1M`                   |
| `resources.limits.cpu`      | CPU 资源限制         | `200m`                 |
| `resources.limits.memory`   | 内存资源限制         | `256Mi`                |
| `resources.requests.cpu`    | CPU 资源请求         | `100m`                 |
| `resources.requests.memory` | 内存资源请求         | `128Mi`                |
| `persistence.enabled`       | 是否启用持久化存储   | `true`                 |
| `persistence.accessMode`    | 存储访问模式         | `ReadWriteOnce`        |
| `persistence.size`          | 存储大小             | `1Gi`                  |
| `persistence.storageClass`  | 存储类名称           | `local`                |
| `env`                       | 环境变量配置（可选） | 见 values.yaml         |

## 数据存储

应用数据存储在容器的 `/data/app` 目录中。此目录通过 PersistentVolumeClaim 持久化，确保数据在 Pod 重启后不会丢失。

## 自定义配置指南

### 修改应用配置

1. **调整资源限制**：根据您的应用需求修改 resources 部分

```yaml
resources:
  limits:
    cpu: 500m # 根据应用需求调整
    memory: 512Mi # 根据应用需求调整
  requests:
    cpu: 200m
    memory: 256Mi
```

2. **配置环境变量**：在 values.yaml 的 env 部分添加所需的环境变量

```yaml
env:
  env1:
    name: DEBUG
    value: "false"
  env2:
    name: LOG_LEVEL
    value: "info"
```

3. **调整持久化存储**：根据数据量调整 persistence 部分

```yaml
persistence:
  size: 10Gi # 根据数据量调整
  storageClass: "fast-storage" # 使用高性能存储类
```

### 网络配置

默认提供了网络带宽限制功能，可以通过以下方式调整：

```yaml
networkLimits:
  enabled: true
  egress: "5M" # 调整出站带宽，K=千字节/秒，M=兆字节/秒
  ingress: "10M" # 调整入站带宽
```

## 文件结构说明

此 Chart 包含以下文件，每个文件都有特定的用途：

- **Chart.yaml**: 包含 Chart 的元数据，如名称、版本、描述等
- **values.yaml**: 默认配置值，用户可以覆盖这些值
- **values.schema.json**: 定义 values.yaml 的结构和验证规则
- **templates/**: 包含 Kubernetes 资源模板
  - **deployment.yaml**: 定义应用的部署配置
  - **service.yaml**: 定义应用的服务配置
  - **pvc.yaml**: 定义持久卷声明
  - **\_helpers.tpl**: 包含可重用的模板片段

## 常见问题

**Q: 如何更改应用的数据目录?**  
A: 修改`deployment.yaml`中的`volumeMounts.mountPath`值，并确保在 README.md 中更新对应的路径说明。

**Q: 为什么服务类型必须是 ClusterIP?**  
A: 为了安全考虑，要求默认使用 ClusterIP 类型。如果需要外部访问，推荐使用 Ingress 控制器。

**Q: 如何添加自定义标签?**  
A: 在 values.yaml 中添加 labels 部分，然后在模板中引用这些标签。

## 升级和迁移

升级 Chart 版本时，请注意查看 CHANGELOG 了解变更内容，特别是可能需要迁移数据的变更。

## 贡献指南

欢迎为此模板做出贡献！请参考[CONTRIBUTING.md](../../../CONTRIBUTING.md)了解贡献流程和规范。
