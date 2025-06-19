# 达不四API管理系统

达不四API管理系统是一款轻量级API管理工具，用于API接口的创建、测试和管理。 - 作者倪鸣

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- 使用Deployment工作负载类型可确保API管理系统的高可用性和易于扩展

## 参数

| 参数                | 描述               | 默认值         |
|---|-----|---|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `niehaoran/api-management`   |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |

## 介绍
达不四API管理系统是一款功能完善的API接口管理平台，提供API文档管理、接口测试、性能监控等功能，帮助开发者高效管理API生命周期。

## 使用说明
### 初始设置
1. 部署完成后，通过浏览器访问应用
2. 使用默认账号密码登录系统（详情请查看系统首页的登录指引）
3. 登录后可以开始创建和管理API接口

### 持久化存储
系统会挂载以下目录:
- `/var/www/html`: 应用程序根目录，存储配置文件和上传数据

## 出处
达不四API管理系统由niehaoran/api-management镜像提供支持。