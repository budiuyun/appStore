# mcsm-daemon

MCSManager Daemon守护进程 - 专业的我的世界服务器管理面板守护进程

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `githubyumao/mcsmanager-daemon` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `10Gi` |
| env | 环境变量配置 | 见下文 |


## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| MCSM_DOCKER_WORKSPACE_PATH | Docker工作目录路径 | `/opt/mcsmanager/daemon/data/InstanceData` |


## 额外挂载

此应用需要以下额外挂载：

- `/var/run/docker.sock:/var/run/docker.sock` - 用于与Docker守护进程通信
- `/etc/localtime:/etc/localtime:ro` - 用于同步容器与主机的时间

## 安装方法

```bash
helm install my-release ./mcsm-daemon
``` 