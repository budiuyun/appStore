# phpmyadmin

phpMyAdmin 是一款流行的基于 Web 的 MySQL 和 MariaDB 数据库管理工具，支持数据库、表、用户、权限等多种操作，界面友好，易于使用。

## 工作负载类型

此 Helm Chart 使用 `Deployment` 工作负载类型，适合无状态应用，方便快速扩展和更新。

## 参数

| 参数                | 描述               | 默认值         |
|---------------------|--------------------|---------------|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `phpmyadmin`  |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| service.ports.web   | Web服务端口        | `80`          |
| persistence.enabled | 是否启用持久化存储 | `false`       |
| persistence.size    | 存储大小           | `1Gi`         |
| persistence.mounts  | 挂载路径           | `[]`          |
| env                | 环境变量配置       | 见下文        |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量           | 描述                       | 默认值           |
|--------------------|----------------------------|------------------|
| PMA_HOST           | 要连接的MySQL服务器主机名  | `db`             |
| PMA_ARBITRARY      | 允许在登录页自定义MySQL服务器地址 | `1`        |
| TZ                 | 时区设置                   | `Asia/Shanghai`  |

## 应用介绍

phpMyAdmin 是一款功能强大的 MySQL/MariaDB 数据库管理工具，通过直观的 Web 界面提供全面的数据库管理功能。它是全球最流行的 MySQL 管理工具之一，被广泛用于开发、测试和生产环境。

主要功能包括：
- 数据库管理：创建、修改、删除数据库
- 表格操作：创建、修改、删除表格和字段
- 数据操作：插入、更新、删除数据记录
- SQL执行：运行自定义SQL查询和脚本
- 用户管理：创建和管理数据库用户及权限
- 导入导出：支持多种格式的数据导入导出
- 关系管理：管理表之间的关系和外键
- 查询统计：查看和优化SQL查询性能

phpMyAdmin 提供友好的图形界面，使数据库管理变得简单直观，即使对于不熟悉 SQL 的用户也能轻松操作。它支持多语言界面，并提供丰富的主题选择，可以根据个人喜好进行定制。

通过Web界面（80端口）可以轻松访问和管理MySQL/MariaDB数据库，是开发人员、数据库管理员和网站维护人员的必备工具。

项目主页：[https://www.phpmyadmin.net/](https://www.phpmyadmin.net/)