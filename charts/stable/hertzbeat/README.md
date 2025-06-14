# hertzbeat

Apache HertzBeat（incubating）是一款开源、易用、无代理的实时监控系统，支持高性能集群、Prometheus 兼容、自定义监控和状态页搭建，适用于网站、数据库、云原生、网络等多场景。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `apache/hertzbeat` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web-ui| Web UI端口         | `1157`        |
| service.ports.cluster| 集群通信端口      | `1158`        |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `2Gi`         |
| persistence.mounts  | 挂载路径           | 见下文        |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

HertzBeat 的数据默认挂载在以下路径：
- `/opt/hertzbeat/data` - 应用数据
- `/opt/hertzbeat/logs` - 应用日志

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| LANG               | 系统语言                   | `en_US.UTF-8`    |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

Apache HertzBeat（incubating）是一款开源的实时监控系统，专注于提供简单易用、无需代理的监控解决方案。它支持对网站、API、数据库、中间件、云原生组件、操作系统和网络设备等多种对象的监控，并提供丰富的可视化和告警功能。

主要特点包括：
- 一站式监控：覆盖IT基础设施、应用服务和业务指标的全方位监控
- 无代理架构：通过标准协议采集数据，无需在目标系统安装代理
- 自定义监控：通过可视化界面快速定义和配置监控指标
- 高性能集群：支持水平扩展的集群部署模式
- Prometheus兼容：支持Prometheus数据格式和查询语言
- 状态页功能：可构建公开的系统状态页面

通过Web界面（1157端口）可以轻松配置监控对象、查看监控数据和设置告警规则，帮助用户快速发现和解决系统问题。

项目主页：[https://hertzbeat.apache.org/](https://hertzbeat.apache.org/)