# github-mcp-server

GitHub MCP Server 官方镜像，提供与 GitHub API 的无缝集成，支持高级自动化和开发者工具交互，适用于自动化开发、CI/CD、代码管理等场景。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `mcp/github-mcp-server` |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web服务端口        | `8080`        |
| persistence.enabled | 是否启用持久化存储 | `false`       |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `[]`          |
| env                | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

GitHub MCP Server 是一个专为开发者和 DevOps 团队设计的服务，提供与 GitHub API 的无缝集成能力。该服务器支持高级自动化和开发者工具交互，是构建自动化开发流程、CI/CD 管道和代码管理系统的理想选择。

主要功能包括：
- GitHub API 集成：支持所有主要的 GitHub API 操作
- 自动化工作流：可配置的事件触发器和操作
- 权限管理：精细的访问控制和权限设置
- Webhook 处理：接收和处理 GitHub 事件通知
- 代码分析：支持代码质量和安全性分析集成
- 报告生成：自动化报告和通知功能

通过 Web 界面（8080端口）可以轻松配置和管理所有功能，支持与现有开发工具链的集成，提高开发团队的效率和代码质量。

项目主页：[https://hub.docker.com/r/mcp/github-mcp-server](https://hub.docker.com/r/mcp/github-mcp-server)