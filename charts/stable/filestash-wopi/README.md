# Filestash WOPI

Collabora Online是一个功能强大的在线办公套件，为Filestash提供文档编辑功能。

## 简介

Collabora Online是一个基于LibreOffice的在线办公套件，支持实时协作编辑文档、电子表格和演示文稿。作为Filestash的WOPI服务器，它使Filestash能够在线编辑Office文档。

## 特点

- 完整的办公套件功能
- 支持多种文档格式
- 实时协作编辑
- 与Filestash无缝集成
- 开源解决方案

## 安装

### 前提条件

- Kubernetes 1.19+
- Helm 3.2.0+
- 已安装Filestash应用

### 安装步骤

```bash
helm repo add budiu https://repo.budibase.com/charts
helm install filestash-wopi budiu/filestash-wopi
```

## 配置

下表列出了Filestash WOPI图表的可配置参数及其默认值。

| 参数 | 描述 | 默认值 |
| ---- | ---- | ------ |
| `replicaCount` | 副本数量 | `1` |
| `image.imageRegistry` | 镜像仓库 | `docker.io` |
| `image.repository` | 镜像名称 | `collabora/code` |
| `image.tag` | 镜像标签 | `24.04.10.2.1` |
| `image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `service.type` | 服务类型 | `ClusterIP` |
| `service.ports.http` | HTTP端口 | `9980` |
| `persistence.enabled` | 是否启用持久化存储 | `true` |
| `persistence.size` | 持久化存储大小 | `2Gi` |
| `persistence.accessMode` | 持久化存储访问模式 | `ReadWriteOnce` |
| `persistence.storageClass` | 持久化存储类 | `local` |
| `persistence.mounts` | 持久化存储挂载点 | `["/var/lib/coolwsd"]` |
| `env.env1.value` | 时区设置 | `Asia/Shanghai` |
| `env.env2.value` | 额外参数 | `"--o:ssl.enable=false"` |
| `env.env3.value` | 域名别名组 | `"https://.*:443"` |
| `command.enabled` | 启用自定义命令 | `true` |
| `command.value` | 自定义命令内容 | 见values.yaml |

## 使用方法

安装完成后，Filestash WOPI服务将与Filestash应用集成：

1. 确保Filestash应用和Filestash WOPI都已正确安装
2. 在Filestash应用中配置WOPI服务器地址（默认为http://wopi_server:9980）
3. 现在您可以在Filestash中打开和编辑Office文档

## 配置Filestash与WOPI集成

要将Filestash与WOPI服务器集成，请确保以下环境变量已正确设置：

- `OFFICE_URL`: WOPI服务器地址（默认为http://wopi_server:9980）
- `OFFICE_FILESTASH_URL`: Filestash应用地址（默认为http://app:8334）
- `OFFICE_REWRITE_URL`: WOPI重写地址（默认为http://127.0.0.1:9980）

## 许可证

Collabora Online是根据MPL 2.0许可证发布的。 