# Chart 格式规范与检查说明

本文档详细说明了 Chart 格式规范、检查要求以及提交流程。请在创建新 Chart 时严格遵循这些规范。

## 目录结构要求

所有提交的 Chart 必须遵循以下结构：

```
app-name-version/                  # 例如：my-app-1.0.0/
└── app-name/                      # 例如：my-app/
    ├── Chart.yaml                 # 必需，包含Chart元数据
    ├── values.yaml                # 必需，包含默认配置
    ├── values.schema.json         # 必需，JSON模式定义
    ├── README.md                  # 必需，使用说明文档
    └── templates/                 # 必需，K8s资源模板目录
        ├── _helpers.tpl           # 必需，辅助函数
        ├── deployment.yaml        # 必需，部署配置
        ├── service.yaml           # 必需，服务配置
        └── pvc.yaml               # 必需，持久卷声明
```

## 文件格式要求与检查规则

### 1. Chart.yaml

**必需字段：**

- `apiVersion`: 必须为`v2`
- `name`: Chart 名称
- `version`: Chart 版本
- `appVersion`: 应用版本
- `description`: 应用描述
- `icon`: 图标 URL
- `annotations`: 必须包含以下注解
  - `yunna.net/category`: 英文分类
  - `yunna.net/category-zh`: 中文分类
- `keywords`: 关键词数组
- `sources`: 源代码链接
- `maintainers`: 维护者信息，必须包含 name 和 email

**成功示例：**

```yaml
apiVersion: v2
name: my-app
version: 1.0.0
appVersion: "1.0.0"
description: "这是一个示例应用"
icon: https://example.com/icon.png
annotations:
  yunna.net/category: database
  yunna.net/category-zh: 数据库
keywords:
  - database
  - mysql
sources:
  - https://github.com/example/my-app
maintainers:
  - name: maintainer
    email: maintainer@example.com
```

**失败示例：**

```yaml
# 缺少apiVersion
name: my-app
version: 1.0.0
# 错误: Chart.yaml 缺少必需字段 'apiVersion'

# 或annotations不完整
apiVersion: v2
name: my-app
version: 1.0.0
annotations:
  # 缺少yunna.net/category-zh
  yunna.net/category: database
# 错误: Chart.yaml annotations 缺少 'yunna.net/category-zh' 字段
```

### 2. values.yaml

**必需部分：**

- `replicaCount`: 副本数量
- `image`: 镜像配置，必须包含
  - `imageRegistry`: 镜像仓库地址
  - `repository`: 镜像名称
  - `tag`: 镜像标签
  - `pullPolicy`: 拉取策略
- `service`: 服务配置，必须包含
  - `type`: 必须是`ClusterIP`
  - `port`: 服务端口
- `resources`: 资源限制，必须包含
  - `limits`: CPU 和内存限制
  - `requests`: CPU 和内存请求
- `persistence`: 持久化配置，必须包含
  - `enabled`: 是否启用
  - `accessMode`: 访问模式
  - `size`: 存储大小
  - `storageClass`: 存储类
- `networkLimits`: 网络限制，必须包含
  - `enabled`: 是否启用
  - `egress`: 出站带宽(如"1M")
  - `ingress`: 入站带宽(如"1M")
- `env`: (可选)环境变量配置

**成功示例：**

```yaml
replicaCount: 1

image:
  imageRegistry: "registry-2.yunna.net"
  repository: example/my-app
  tag: "latest"
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 8080

networkLimits:
  enabled: true
  egress: "1M"
  ingress: "1M"

resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi

persistence:
  enabled: true
  accessMode: ReadWriteOnce
  size: 1Gi
  storageClass: "local"
```

**失败示例：**

```yaml
# service.type不是ClusterIP
service:
  type: NodePort
  port: 8080
# 错误: service.type 必须设置为 ClusterIP，当前值为 NodePort

# 或networkLimits格式错误
networkLimits:
  enabled: true
  egress: "100" # 缺少单位K、M或G
  ingress: "1M"
# 错误: networkLimits.egress 值 (100) 格式不正确，必须包含数字和单位(K, M, G)
```

### 3. values.schema.json

**要求：**

- 必须是有效的 JSON Schema
- 必须包含与 values.yaml 中所有字段对应的定义
- 服务类型必须限制为只能是 ClusterIP

**成功示例：**

```json
{
  "$schema": "http://json-schema.org/schema#",
  "type": "object",
  "properties": {
    "replicaCount": {
      "type": "integer",
      "title": "副本数量",
      "minimum": 1,
      "default": 1
    },
    "service": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "enum": ["ClusterIP"]
        },
        "port": {
          "type": "integer"
        }
      }
    }
  }
}
```

**失败示例：**

```json
{
  "$schema": "http://json-schema.org/schema#",
  "type": "object",
  "properties": {
    // 缺少values.yaml中的networkLimits定义
    // 错误: values.yaml中的'networkLimits'属性在values.schema.json中未定义

    "service": {
      "type": "object",
      "properties": {
        "type": {
          "type": "string",
          "enum": ["ClusterIP", "NodePort"] // 允许了非ClusterIP类型
          // 错误: values.schema.json中service.type必须限制为ClusterIP
        }
      }
    }
  }
}
```

### 4. templates/deployment.yaml

**要求：**

- 必须使用 Kubernetes Deployment 资源
- 必须正确引用 values.yaml 中的配置
- 必须定义卷挂载路径(mountPath)
- 必须配置网络限制注解

**成功示例：**

```yaml
apiVersion: apps/v1
kind: Deployment
spec:
  replicas: {{ .Values.replicaCount }}
  template:
    metadata:
      {{- if .Values.networkLimits.enabled }}
      annotations:
        kubernetes.io/egress-bandwidth: {{ .Values.networkLimits.egress | quote }}
        kubernetes.io/ingress-bandwidth: {{ .Values.networkLimits.ingress | quote }}
      {{- end }}
    spec:
      containers:
        - image: "{{ .Values.image.imageRegistry }}/{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          imagePullPolicy: "{{ .Values.image.pullPolicy }}"
          resources:
            requests:
              memory: "{{ .Values.resources.requests.memory }}"
              cpu: "{{ .Values.resources.requests.cpu }}"
            limits:
              memory: "{{ .Values.resources.limits.memory }}"
              cpu: "{{ .Values.resources.limits.cpu }}"
          volumeMounts:
            - name: data
              mountPath: /data/myapp  # 应用的实际数据目录
```

**失败示例：**

```yaml
# 硬编码replicas值而不引用values.yaml
spec:
  replicas: 1 # 应该使用{{ .Values.replicaCount }}
# 错误: deployment.yaml 中的replicas必须引用.Values.replicaCount

# 或缺少挂载路径
volumeMounts: [] # 没有定义挂载路径
# 错误: deployment.yaml 必须包含卷挂载路径(mountPath)
```

### 5. templates/service.yaml

**要求：**

- 类型必须引用 values.yaml 中的 service.type(必须是 ClusterIP)
- 端口必须引用 values.yaml 中的配置
- targetPort 必须与 deployment 中的 containerPort 一致

**成功示例：**

```yaml
apiVersion: v1
kind: Service
spec:
  type: { { .Values.service.type } }
  ports:
    - port: { { .Values.service.port } }
      targetPort: 8080 # 与deployment中的containerPort相同
```

**失败示例：**

```yaml
# 硬编码service.type
spec:
  type: ClusterIP # 应该使用{{ .Values.service.type }}
# 错误: service.yaml 中的type必须引用.Values.service.type
```

### 6. templates/pvc.yaml

**要求：**

- 必须引用 values.yaml 中的 persistence 配置

**成功示例：**

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
spec:
  accessModes:
    - { { .Values.persistence.accessMode } }
  resources:
    requests:
      storage: { { .Values.persistence.size } }
  storageClassName: { { .Values.persistence.storageClass | quote } }
```

**失败示例：**

```yaml
# 硬编码存储大小
spec:
  resources:
    requests:
      storage: 1Gi # 应该使用{{ .Values.persistence.size }}
# 错误: pvc.yaml 中的storage必须引用.Values.persistence.size
```

### 7. templates/\_helpers.tpl

**要求：**

- 必须定义以下辅助函数：
  - fullname
  - name
  - labels
  - selectorLabels

**成功示例：**

```
{{- define "app.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
{{- end -}}

{{- define "app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "app.name" . }}
{{- end -}}
```

**失败示例：**

```
# 缺少必要的helper函数
{{- define "app.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
# 错误: _helpers.tpl 缺少必要的helper函数 'selectorLabels'
```

### 8. README.md

**要求：**

- 必须包含应用描述信息
- 必须包含安装或使用说明
- 必须包含数据持久化信息
- 必须说明实际的挂载路径(与 deployment.yaml 中定义的一致)

**成功示例：**

````markdown
# My Application

这是一个示例应用，用于演示配置。

## 安装方法

使用以下命令安装：

```bash
helm install my-app ./charts/stable/my-app/my-app
```
````

## 数据存储

应用数据存储在`/data/myapp`目录中，通过 PVC 持久化。此路径需要挂载持久卷以防止数据丢失。

````

**失败示例：**

```markdown
# My Application

这是一个示例应用。

## 安装方法
使用Helm安装。

# 未说明确切的挂载路径
# 错误: README.md 必须说明实际的挂载路径 (/data/myapp)
````

## 模板渲染检查

系统会使用`helm template`命令渲染模板，并检查以下内容：

1. 模板是否能成功渲染
2. 渲染后是否生成了必需的资源类型
3. Service 类型是否为 ClusterIP

**成功：** 模板渲染后包含 Deployment、Service 和 PersistentVolumeClaim 资源，且 Service 类型为 ClusterIP。

**失败：** 模板渲染错误或 Service 类型不是 ClusterIP。

## 文件之间的关联检查

系统会检查以下文件之间的关联：

1. values.yaml 与 values.schema.json 一致性
2. values.yaml 与模板文件的引用关系
3. 模板文件之间的一致性(如 containerPort 和 targetPort)

## 总结

遵循以上规范可以确保您的 Chart 能够顺利通过检查。建议在创建新 Chart 时：

1. 使用本模板作为起点
2. 严格遵循文件结构和内容要求
3. 在提交前本地进行测试
4. 确保所有文件之间的引用关系正确

如有疑问，请参考[uptime-kuma](../uptime-kuma-0.1.1/uptime-kuma/)作为示例。
