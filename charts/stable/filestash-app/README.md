# Filestash

Filestash是一个现代化的Web文件管理器，支持多种存储后端，包括FTP、SFTP、WebDAV、Git、S3等。

## 简介

Filestash是一个自托管的Web文件管理器，允许您通过Web浏览器访问和管理各种存储服务中的文件。它提供了直观的界面，支持文件预览、编辑和共享功能。

## 特点

- 支持多种存储后端：FTP、SFTP、WebDAV、S3、Dropbox等
- 文件预览：图片、视频、音频、PDF、文本文件等
- 文件编辑：支持在线编辑文本文件
- 文件共享：生成共享链接
- 移动设备友好：响应式设计
- 安全：端到端加密

## 安装

### 前提条件

- Kubernetes 1.19+
- Helm 3.2.0+

### 安装步骤

```bash
helm repo add budiu https://repo.budibase.com/charts
helm install filestash-app budiu/filestash-app
```

## 配置

下表列出了Filestash图表的可配置参数及其默认值。

| 参数 | 描述 | 默认值 |
| ---- | ---- | ------ |
| `workloadType` | 工作负载类型 | `Deployment` |
| `replicaCount` | 副本数量 | `1` |
| `image.imageRegistry` | 镜像仓库 | `docker.io` |
| `image.repository` | 镜像名称 | `machines/filestash` |
| `image.tag` | 镜像标签 | `latest` |
| `image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `service.type` | 服务类型 | `ClusterIP` |
| `service.ports.http` | HTTP端口 | `8334` |
| `persistence.enabled` | 是否启用持久化存储 | `true` |
| `persistence.size` | 持久化存储大小 | `2Gi` |
| `persistence.accessMode` | 持久化存储访问模式 | `ReadWriteOnce` |
| `persistence.storageClass` | 持久化存储类 | `local` |
| `persistence.mounts` | 持久化存储挂载点 | `["/app/data/state"]` |
| `env.env1.value` | 时区设置 | `Asia/Shanghai` |
| `env.env2.value` | 应用URL | `""` |
| `env.env3.value` | 启用Canary | `"true"` |
| `env.env4.value` | Office服务器URL | `"http://wopi_server:9980"` |
| `env.env5.value` | Filestash应用URL | `"http://app:8334"` |
| `env.env6.value` | Office重写URL | `"http://127.0.0.1:9980"` |
| `extraVolumeMounts` | 额外的卷挂载 | 见values.yaml |
| `extraVolumes` | 额外的卷 | 见values.yaml |

## 使用方法

安装完成后，您可以通过以下步骤访问Filestash管理界面：

1. 获取服务的IP地址：

```bash
kubectl get svc --namespace default filestash-app -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

2. 使用浏览器访问：`http://<服务IP>:8334`

3. 按照界面提示完成初始设置

## 配置存储后端

Filestash支持多种存储后端，您可以在Web界面中配置：

1. 登录Filestash管理界面
2. 点击"设置"图标
3. 选择"后端"选项卡
4. 配置所需的存储后端（FTP、SFTP、S3等）

## 许可证

Filestash是根据AGPLv3许可证发布的。 