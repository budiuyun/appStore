# windows

windows server容器化系统

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| workloadType | 工作负载类型 | `Deployment` |
| replicaCount | 副本数量 | `1` |
| image.imageRegistry | 镜像仓库地址 | `docker.io` |
| image.repository | 镜像名称 | `dockurr/windows` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.web | Web服务端口 | `8006` |
| service.ports.rdp | RDP远程桌面端口 | `3389` |
| resources.limits.cpu | CPU资源限制 | `4` |
| resources.limits.memory | 内存资源限制 | `8Gi` |
| resources.requests.cpu | CPU资源请求 | `2` |
| resources.requests.memory | 内存资源请求 | `4Gi` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.path | 持久化存储路径 | `/storage` |
| persistence.accessMode | 存储访问模式 | `ReadWriteOnce` |
| persistence.size | 存储大小 | `20Gi` |
| persistence.storageClass | 存储类 | `local` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 | 标题 |
|---------|------|--------|------|
| VERSION | 选择安装的windows版本 | `2022` | windows版本 |
| DISK_SIZE | 设置系统磁盘大小 | `20G` | 磁盘大小 |
| RAM_SIZE | 设置分配的内存大小 | `4G` | 内存大小 |
| CPU_CORES | 设置分配的cpu核心数 | `2` | cpu核心数 |
| USERNAME | 设置windows登录用户名 | `docker` | 用户名 |
| PASSWORD | 设置windows登录密码 | `admin` | 密码 |
| LANGUAGE | 设置windows系统语言 | `Chinese` | 语言 |


## 安装方法

```bash
helm install my-release ./windows
```