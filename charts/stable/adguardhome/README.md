# AdGuard Home

AdGuard Home 是一款全网广告拦截与反跟踪软件。在您将其安装完毕后，它将保护您所有家用设备，同时您不再需要安装任何客户端软件。

## 简介

AdGuard Home 是一个网络范围内的广告和跟踪器阻止 DNS 服务器。安装后，它将覆盖您的设备的 DNS 设置，以便阻止整个网络上的广告和跟踪器，而不需要任何客户端软件。

## 特点

- 阻止整个网络上的广告和跟踪器
- 自定义过滤规则
- 家长控制
- 加密 DNS 服务器
- 实时统计和可视化
- 保护所有设备，无需安装客户端软件

## 安装

### 前提条件

- Kubernetes 1.19+
- Helm 3.2.0+

### 安装步骤

```bash
helm repo add budiu https://repo.budibase.com/charts
helm install adguardhome budiu/adguardhome
```

## 配置

下表列出了 AdGuard Home 图表的可配置参数及其默认值。

| 参数 | 描述 | 默认值 |
| ---- | ---- | ------ |
| `replicaCount` | 副本数量 | `1` |
| `image.imageRegistry` | 镜像仓库 | `docker.io` |
| `image.repository` | 镜像名称 | `adguard/adguardhome` |
| `image.tag` | 镜像标签 | `latest` |
| `image.pullPolicy` | 镜像拉取策略 | `IfNotPresent` |
| `service.type` | 服务类型 | `ClusterIP` |
| `service.ports.dns-tcp` | DNS TCP 端口 | `53` |
| `service.ports.dns-udp` | DNS UDP 端口 | `53` |
| `service.ports.http` | HTTP 管理界面端口 | `3000` |
| `persistence.enabled` | 是否启用持久化存储 | `true` |
| `persistence.size` | 持久化存储大小 | `2Gi` |
| `persistence.accessMode` | 持久化存储访问模式 | `ReadWriteOnce` |
| `persistence.storageClass` | 持久化存储类 | `local` |
| `persistence.mounts` | 持久化存储挂载点 | `["/opt/adguardhome/work"]` |

## 使用方法

安装完成后，您可以通过以下步骤访问 AdGuard Home 管理界面：

1. 获取服务的 IP 地址：

```bash
kubectl get svc --namespace default adguardhome -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

2. 使用浏览器访问：`http://<服务IP>:3000`

3. 按照界面提示完成初始设置

## 配置 DNS

要让您的设备使用 AdGuard Home 作为 DNS 服务器，您需要在路由器或每个设备上配置 DNS 设置：

1. 路由器配置：将路由器的 DNS 服务器设置为 AdGuard Home 的 IP 地址
2. 设备配置：在设备网络设置中手动设置 DNS 服务器为 AdGuard Home 的 IP 地址

## 许可证

AdGuard Home 是根据 GPL v3 许可证发布的。 