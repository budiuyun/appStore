# Helm Charts 多租户仓库

本仓库是一个多租户的 Helm Charts 托管平台，允许多个用户/组织在不丢云平台上创建和维护自己的 Chart 集合。

## 一、快速入门

> **📢 重要更新：** 我们现在提供了应用生成器工具！访问 [不丢云应用生成器](https://budiuyun.github.io/AppStoreGenerators/) 可以快速生成符合规范的应用模板，无需手动创建所有文件。

### 1. 基本流程

开始创建您的应用有两种方式：

#### A. 使用应用生成器（推荐）

1. 访问 [不丢云应用生成器](https://budiuyun.github.io/AppStoreGenerators/)
2. 按照界面引导填写所有必要的应用信息
   - 应用图标需要提供URL，可使用[不丢云图床](https://tuchuang.yunnaio.cn/upload)上传并获取链接
3. 生成并下载Helm Chart文件包
4. 根据需要对生成的文件进行进一步调整

#### B. 手动创建（高级用户）

开始创建您的应用只需几个简单步骤：

1. **修改 Chart.yaml 基本信息**
   - 更新 `name`、`version` 和 `appVersion` 
   - 编写清晰的 `description`
   - 设置合适的 `icon` URL
   - 添加相关 `keywords` 便于搜索
   - 填写 `maintainers` 信息（必须包含name和email）
   - 确保 `annotations` 中包含正确的分类信息

2. **配置 values.yaml**
   - 设置合适的 `image` 信息（imageRegistry、repository、tag）
   - 根据应用需求配置 `resources` 资源限制
   - 添加必要的 `env` 环境变量
   - 配置 `persistence` 持久化存储参数
   - 设置 `networkLimits` 网络带宽限制

3. **配置正确的持久卷位置**
   - 在 `deployment.yaml` 中设置正确的数据挂载路径 `mountPath`
   - 确保此路径与应用程序实际存储数据的位置一致
   - 在README中清晰说明此数据存储路径
   - 根据应用数据需求配置合适的存储大小

4. **更新 values.schema.json**
   - 确保与 values.yaml 中的所有参数对应
   - 重点更新 `env` 部分的定义
   - 更新各参数的 `default` 默认值
   - 添加合适的参数描述和验证规则

5. **验证应用（可选）**
   - 您可以在提交前进行本地验证，但这不是必需的
   - 平台会在您提交后自动对应用进行全面验证
   - 如有格式问题，系统会通知您需要修正的地方
   - 本地验证可使用 `helm lint` 命令检查基本语法

### 2. 格式规范说明

我们对应用的格式有严格要求，这主要出于以下考虑：

1. **平台兼容性**：固定的文件格式确保应用能在不丢云平台上正常运行
2. **自动化部署**：标准格式允许平台自动识别和部署您的应用
3. **用户体验一致性**：统一的参数结构让用户更容易理解和配置不同的应用
4. **服务类型限制**：服务类型固定为ClusterIP是为了更好地集中管理网络流量和安全策略
5. **持久化存储标准化**：规范化的存储配置确保数据安全和有效管理

> **特别说明**：服务类型限制为ClusterIP并不会影响应用的可用性，平台会通过统一的网关和路由机制为应用提供外部访问能力。

### 3. 参考示例

本仓库提供了完整的示例应用，您可以参考：
- [示例应用](./示例helm文件/template-app-1.0.0/template-app)

只需复制此示例并按照您的需求修改，即可快速创建符合规范的应用。

## 二、详细参数说明

### Chart.yaml 关键字段

| 字段 | 说明 | 是否必需 | 示例 |
|------|------|----------|------|
| apiVersion | Chart API版本，必须为v2 | 是 | `apiVersion: v2` |
| name | Chart名称，必须与目录名匹配 | 是 | `name: my-app` |
| version | Chart版本号，遵循语义化版本规范 | 是 | `version: 1.0.0` |
| appVersion | 应用程序版本号 | 是 | `appVersion: "1.0.0"` |
| description | 应用描述，简明扼要 | 是 | `description: "这是一个示例应用"` |
| icon | 应用图标URL，必须可公开访问 | 是 | `icon: https://example.com/icon.png` |
| keywords | 关键词，用于分类和搜索 | 是 | `keywords: ["web", "app"]` |
| sources | 源代码仓库链接 | 是 | `sources: ["https://github.com/example/app"]` |
| maintainers | 维护者信息，必须包含name和email | 是 | `maintainers: [{name: "维护者", email: "email@example.com"}]` |
| annotations | 注解，用于提供额外的元数据 | 是 | `annotations: {budiu/app-category-zh: "数据库"}` |

> **📢 应用图标上传说明：** 您可以使用不丢云官方提供的图片托管服务 [图床](https://tuchuang.yunnaio.cn/upload) 上传您的应用图标。上传后，复制获得的URL作为 `icon` 字段的值。请确保上传的图标分辨率合适且清晰可辨。

### 应用分类说明

应用分类是不丢云平台对应用进行归类管理的重要标识。在Chart.yaml中，必须通过`annotations`部分指定应用分类：

```yaml
annotations:
  budiu/app-category-zh: "数据库"  # 必须使用budiu/app-category-zh作为分类标识
```

#### 分类示例

以下是平台推荐的应用分类：

| 分类名称 | 适用范围 | 示例应用 |
|---------|---------|---------|
| 数据库 | 各类数据库系统 | MySQL, PostgreSQL, MongoDB |
| 中间件 | 消息队列、缓存等 | Redis, RabbitMQ, Kafka |
| 开发工具 | 开发辅助工具 | Git, Jenkins, Maven |
| 监控工具 | 性能监控、日志分析 | Prometheus, ELK, Grafana |
| 应用工具 | 通用应用支持 | Nginx, Tomcat |
| Web应用 | 网站和Web服务 | WordPress, Drupal |
| 存储系统 | 分布式存储 | MinIO, Ceph |
| 其他 | 不属于上述分类的应用 | 自定义应用 |

请选择最匹配您应用特性的分类。如不确定，可使用"其他"分类。

### values.yaml 关键配置

| 配置段 | 说明 | 是否必需 | 示例 |
|--------|------|----------|------|
| replicaCount | 副本数量 | 是 | `replicaCount: 1` |
| image | 镜像配置 | 是 | 见下文 |
| service | 服务配置 | 是 | `service: {type: ClusterIP, port: 80}` |
| networkLimits | 网络带宽限制 | 是 | `networkLimits: {enabled: true, egress: "1M", ingress: "1M"}` |
| resources | 资源限制 | 是 | 见下文 |
| persistence | 持久化存储配置 | 是 | 见下文 |
| env | 环境变量配置 | 否 | 见下文 |

#### 镜像配置详解
```yaml
image:
  imageRegistry: "registry-2.yunna.net"  # 镜像仓库地址
  repository: myapp/web                  # 镜像名称
  tag: "1.0.0"                          # 镜像标签
  pullPolicy: IfNotPresent              # 拉取策略，必须使用IfNotPresent
```

#### 资源限制详解
```yaml
resources:
  limits:                      # 资源上限
    cpu: 200m                  # CPU上限，建议设置为requests的2倍
    memory: 256Mi              # 内存上限，建议根据应用实际需求设置
  requests:                    # 资源请求
    cpu: 100m                  # CPU请求，最小建议50m
    memory: 128Mi              # 内存请求，最小建议64Mi
```

#### 持久化存储详解
```yaml
persistence:
  enabled: true                # 是否启用持久化
  accessMode: ReadWriteOnce    # 访问模式，通常使用ReadWriteOnce
  size: 1Gi                    # 存储大小，建议根据数据量估算
  storageClass: "local"        # 存储类，可使用平台提供的存储类
```

#### 环境变量配置详解
```yaml
env:
  env1:                        # 环境变量标识符，可自定义
    name: APP_MODE             # 环境变量名称，容器中可见的名称
    value: production          # 环境变量值
  env2:
    name: DEBUG
    value: "false"
```

### values.schema.json

values.schema.json 文件用于定义 values.yaml 的数据结构和验证规则。更新此文件时，请确保：

1. **保持结构一致性**：schema中的结构必须与values.yaml完全一致
2. **添加属性描述**：为每个属性添加清晰的description
3. **设置默认值**：default字段应与values.yaml中的值匹配
4. **添加类型验证**：使用type字段确保数据类型正确
5. **添加格式验证**：对特殊格式的字段添加pattern或enum限制

特别注意env部分的更新，需要根据您应用的环境变量需求定制。

## 三、在不丢云平台添加您的仓库

您可以使用[不丢云应用生成器](https://budiuyun.github.io/AppStoreGenerators/)快速创建符合规范的应用，或按照以下步骤手动添加您的仓库：

### 1. 申请开通分支

1. **联系管理员申请分支**
   - 通过GitHub Issue或QQ联系：179866495
   - 说明您的组织/团队名称和用途
   - 等待管理员审核并授权

2. **准备您的应用**
   - Fork本仓库到您的GitHub账户
   - 创建符合要求的Helm Chart应用
   - 确保通过所有格式检查

### 2. 发布您的应用

1. **推送到您的分支**
   - 将修改推送到您的分支
   - GitHub Actions会自动检查您的应用格式
   - 检查通过后，系统会自动创建`helm-{您的分支名}`分支

2. **验证发布结果**
   - 访问`https://raw.githubusercontent.com/{您的GitHub用户名}/{仓库名}/helm-{您的分支名}/`
   - 确认index.yaml和Chart包已正确生成

### 3. 在不丢云平台使用

一旦您的应用仓库创建成功，不丢云平台会自动识别并显示您的仓库。您和您的团队可以：

- 在平台应用商店中浏览并安装您的应用
- 根据需要更新应用版本
- 管理应用的部署和配置

## 四、反馈与支持

我们重视您的体验和反馈：

- **报告问题**：通过GitHub Issue报告任何遇到的问题
- **功能建议**：提交功能建议或改进意见
- **寻求帮助**：如需技术支持，请联系QQ：179866495
- **贡献改进**：欢迎提交Pull Request改进文档或工具
- **应用生成器**：访问[不丢云应用生成器](https://budiuyun.github.io/AppStoreGenerators/)，体验更简便的应用创建方式

我们会积极响应您的反馈，持续优化平台和工具链，为您提供更好的应用托管和部署体验。
