# mariadb

MariaDB Server是一个高性能开源关系型数据库，从MySQL分支而来

## 应用介绍

本应用提供以下功能：
- 高性能关系型数据库：适用于各种应用场景
- MySQL兼容性：保持与MySQL APIs和命令的高度兼容
- 持久化存储：确保数据安全可靠
- 灵活配置：通过环境变量轻松配置
- 多版本支持：提供多个稳定版本选择

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 镜像标签 | MariaDB版本 | `latest` |
| 服务端口 | 数据库服务端口 | `3306` |
| 资源限制 | CPU和内存限制 | 见下文 |
| 持久化存储 | 数据存储配置 | 见下文 |

### 资源配置
- CPU限制: 500m（相当于0.5核心）
- 内存限制: 1Gi（相当于1GB）
- CPU请求: 100m（相当于0.1核心）
- 内存请求: 256Mi（相当于256MB）

### 持久化存储配置
- 启用持久化: true（建议开启）
- 挂载路径: /var/lib/mysql
- 存储大小: 8Gi（可根据需求调整）
- 存储类: local（取决于集群环境）

## 数据存储

MariaDB的数据存储在容器的 `/var/lib/mysql` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，特别是如果您的数据库需要存储大量数据。推荐至少8GB的存储空间用于生产环境。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：
   - 数据库客户端：连接到服务的3306端口
   - 使用标准MySQL客户端工具，如MySQL Workbench或phpMyAdmin

2. 连接信息：
   - 服务器地址：集群内可使用服务名称
   - 端口：3306
   - 用户名：由MARIADB_USER环境变量设置
   - 密码：由MARIADB_PASSWORD环境变量设置
   - 数据库：由MARIADB_DATABASE环境变量设置

3. 管理员访问：
   - 用户名：root
   - 密码：由MARIADB_ROOT_PASSWORD环境变量设置

## 环境变量配置

MariaDB支持多种环境变量配置，主要包括：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| MARIADB_ROOT_PASSWORD | MariaDB root用户的密码 | `password` |
| MARIADB_DATABASE | 要创建的初始数据库名称 | `default` |
| MARIADB_USER | 要创建的数据库用户名 | `user` |
| MARIADB_PASSWORD | 数据库用户的密码 | `password` |
| MARIADB_CHARACTER_SET | 数据库默认字符集 | `utf8mb4` |
| MARIADB_COLLATE | 数据库默认排序规则 | `utf8mb4_unicode_ci` |

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用网络策略限制数据库访问
- 定期备份数据库
- 限制root用户的远程访问
- 配置适当的资源限制，避免资源耗尽