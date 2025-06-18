# vitess-lite

MySQL数据库水平扩展集群系统的轻量级版本

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `vitess/lite` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.vtctld-web | vtctld Web界面端口 | `15991` |
| service.ports.vtctld-grpc | vtctld gRPC端口 | `15999` |
| service.ports.vtgate-mysql | vtgate MySQL协议端口 | `15306` |
| service.ports.vtgate-grpc | vtgate gRPC端口 | `15001` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `10Gi` |

## 环境变量

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| TOPOLOGY_FLAGS | Vitess拓扑服务器配置 | `-topo_implementation etcd2 -topo_global_server_address localhost:2379` |
| CELL | Vitess单元名称 | `zone1` |

## 持久化存储

Vitess数据默认存储在容器的 `/vt/vtdataroot` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

Vitess是一个用于MySQL水平扩展的数据库集群系统，最初由Google开发，现由云原生计算基金会(CNCF)管理。vitess/lite是Vitess的轻量级版本，只包含核心组件，适合开发测试和资源受限环境。

主要功能包括：
- 水平分片：支持MySQL数据库的水平扩展
- 连接池：优化数据库连接资源利用
- 查询路由：智能路由查询到适当的分片
- 热备份：支持在线备份和恢复
- 自动故障转移：在主节点故障时自动提升从节点
- 在线架构变更：不中断服务的情况下修改表结构
- 分布式事务：支持跨分片事务处理

## 使用说明

### 基本设置

部署Vitess集群需要配置以下组件：

1. **拓扑服务器**：通常使用etcd或ZooKeeper
2. **vtctld**：提供集群管理界面
3. **vtgate**：查询路由服务
4. **vttablet**：运行在每个MySQL实例上的代理

### 部署示例

完整部署配置较复杂，建议参考官方文档。基本的开发测试环境可以使用以下命令启动：

```bash
docker run -d -p 15991:15991 -p 15306:15306 \
  -v vtdata:/vt/vtdataroot \
  vitess/lite vtcombo \
  -topo_implementation etcd2 \
  -topo_global_server_address localhost:2379 \
  -cell zone1 \
  -schema_dir /vt/src/vitess.io/vitess/examples/schema
```

## 相关链接

- 官方仓库：https://github.com/vitessio/vitess
- 文档网站：https://vitess.io/docs/