# registry

Docker Registry 是 OCI 分发规范的实现，用于本地或私有云环境下存储和分发容器镜像和制品，支持多架构和高可用部署。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `registry`    |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.registry | 镜像仓库端口    | `5000`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `5Gi`         |
| persistence.mounts  | 挂载路径           | `/var/lib/registry` |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

Docker Registry 的数据默认存储在容器的 `/var/lib/registry` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间，推荐生产环境至少 5Gi。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

Docker Registry 是一个用于存储和分发 Docker 镜像的开源应用程序，它实现了 OCI（Open Container Initiative）分发规范，可以在本地或私有云环境中部署，为容器化应用提供镜像存储服务。

主要功能包括：
- 镜像存储：安全存储 Docker 镜像和其他 OCI 兼容制品
- 镜像分发：提供高效的镜像拉取和推送服务
- 多架构支持：支持不同CPU架构的镜像管理
- 访问控制：支持基本认证和 TLS 加密
- 存储后端：支持多种存储后端，如本地文件系统、S3、Azure等
- 镜像垃圾回收：支持清理未使用的镜像层
- API兼容：完全兼容 Docker Registry HTTP API V2
- 可扩展性：支持水平扩展和高可用部署

Docker Registry 是构建私有容器生态系统的基础组件，适用于企业内部镜像管理、CI/CD 流水线集成、边缘计算和离线环境等场景。通过 5000 端口可以进行镜像的推送和拉取操作。

项目主页：[https://docs.docker.com/registry/](https://docs.docker.com/registry/)