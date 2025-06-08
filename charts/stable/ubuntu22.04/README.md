# ubuntu-22-04

带有SSH服务的Ubuntu镜像，支持远程管理，具有持久化存储功能，可以像虚拟机一样使用。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `niehaoran/ubuntu-ssh` |
| image.tag | 镜像标签 | `22.04` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `10Gi` |
| persistence.mounts | 持久卷挂载路径 | `/root`, `/home`, `/etc`, `/var/lib`, `/opt`, `/usr/local`, `/var/log`, `/tmp` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| ROOT_PASSWORD | SSH登录的root用户密码 | `budiu123` |
| TZ | 容器的时区设置 | `Asia/Shanghai` |

## 持久卷挂载说明

本Chart支持多路径持久卷挂载，使Ubuntu容器可以像虚拟机一样保存数据。它通过以下方式实现：

1. 初始化容器(initContainer)会检查每个挂载路径对应的持久卷是否为空
2. 如果为空，会将系统原始数据复制到持久卷中
3. 主容器使用subPath将持久卷的子目录挂载到对应的系统路径

这样可以确保系统文件和用户数据在重启后仍然保留，同时避免不同目录之间的数据冲突。

## 安装方法

```bash
helm install my-release ./ubuntu-22-04
```