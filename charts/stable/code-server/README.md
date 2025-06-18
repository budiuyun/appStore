# code-server

浏览器中运行的VS Code，随时随地编写代码

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `codercom/code-server` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | HTTP端口 | `8080` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `10Gi` |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| PASSWORD | code-server访问密码 | `` |
| DOCKER_USER | 容器内用户名映射 | `coder` |
| SUDO_ACCESS | 是否允许用户使用sudo，true或false | `false` |

## 持久化存储

Code-server的数据默认存储在容器的以下目录中：
- `/home/coder/project`：项目工作空间
- `/home/coder/.config`：配置文件目录

启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

Code-server是一个在浏览器中运行VS Code的应用程序，提供了与桌面版VS Code几乎相同的功能和体验，同时具有以下优势：

- **随处编码**：可以在Chromebook、平板电脑和笔记本电脑上使用一致的开发环境
- **强大的服务器**：利用大型云服务器加速测试、编译、下载等任务
- **节省电池寿命**：所有密集型任务都在服务器上运行，减少本地设备的资源消耗
- **远程开发**：将闲置电脑变成完整的开发环境，通过浏览器远程访问

主要功能包括：
- 完整的VS Code编辑体验
- 丰富的扩展支持
- 集成终端
- 多语言支持
- 代码调试能力
- Git集成
- 远程协作可能性