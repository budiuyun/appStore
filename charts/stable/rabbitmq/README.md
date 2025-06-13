# rabbitmq

RabbitMQ 是一款开源的多协议消息中间件，支持 AMQP、MQTT、STOMP 等协议，广泛应用于消息队列、异步通信和微服务架构中，支持高可用和集群部署。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `rabbitmq`    |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.amqp  | AMQP协议端口       | `5672`        |
| service.ports.management | 管理界面端口  | `15672`       |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `2Gi`         |
| persistence.mounts  | 挂载路径           | `/var/lib/rabbitmq` |
| env                | 环境变量配置       | 见下文        |

## 持久化存储

RabbitMQ 的数据默认存储在容器的 `/var/lib/rabbitmq` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| RABBITMQ_DEFAULT_USER | RabbitMQ 默认登录用户名 | `guest`          |
| RABBITMQ_DEFAULT_PASS | RabbitMQ 默认登录密码   | `guest`          |
| RABBITMQ_DEFAULT_VHOST | RabbitMQ 默认虚拟主机  | `/`              |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

RabbitMQ 是一款高性能、可靠的开源消息代理软件，实现了高级消息队列协议（AMQP）。它作为消息中间件，在分布式系统中扮演着重要角色，用于处理应用程序之间的异步通信。

主要特点包括：
- 多协议支持：原生支持AMQP，通过插件支持MQTT、STOMP等多种协议
- 可靠性：支持消息确认、持久化和高可用配置
- 灵活路由：支持多种交换机类型（direct、topic、fanout、headers）
- 集群能力：支持水平扩展的集群部署
- 插件系统：丰富的插件生态，可扩展功能
- 管理界面：直观的Web管理界面，方便监控和管理
- 安全机制：支持TLS、SASL认证和细粒度的权限控制
- 跨语言支持：提供多种编程语言的客户端库

RabbitMQ 广泛应用于微服务架构、任务队列、实时数据处理、日志收集等场景，通过管理界面（15672端口）可以轻松监控和管理消息队列，是构建可靠分布式系统的理想选择。

项目主页：[https://www.rabbitmq.com/](https://www.rabbitmq.com/)