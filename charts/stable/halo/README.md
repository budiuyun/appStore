# halo

强大易用的开源建站工具。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `halohub/halo` |
| image.tag | 镜像标签 | `2.21` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | Web服务端口 | `8090` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `5Gi` |

## 持久化存储

Halo的数据默认存储在容器的 `/root/.halo2` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

Halo是一款现代化的开源博客/CMS系统，基于Spring Boot和Vue.js开发，支持Markdown编辑器，拥有丰富的主题和插件生态。

主要功能包括：
- 现代化仪表盘：简洁而强大的管理后台
- Markdown编辑：支持所见即所得的Markdown编辑器
- 多主题支持：丰富的主题生态系统
- 插件系统：强大的插件扩展能力
- 多用户协作：支持团队协作编辑
- 完全开源：基于GPL-v3.0协议开源
- 自定义页面：支持自定义页面创建
- 多站点支持：同一实例可管理多个站点
- 强大API：完整的API支持

## 快速开始

如果你的设备有Docker环境，可以使用以下命令快速启动一个Halo的体验环境：

```bash
docker run -d --name halo -p 8090:8090 -v ~/.halo2:/root/.halo2 halohub/halo:2.21
```

详细部署文档请查阅：https://docs.halo.run/getting-started/install/docker-compose

## 相关链接

- 官网：https://www.halo.run
- 文档：https://docs.halo.run
- 论坛：https://bbs.halo.run
- GitHub：https://github.com/halo-dev