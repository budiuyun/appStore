# wordpress

WordPress 是一个功能强大的内容管理系统，可以使用插件、小部件和主题

## 应用介绍

本应用提供以下功能：

- WordPress 6.8.1：功能强大的内容管理系统
- 支持插件和主题：可扩展的功能和自定义外观
- 用户友好的界面：直观的内容编辑体验
- 支持持久化存储：确保数据安全

## 配置说明

| 参数       | 说明           | 默认值   |
| ---------- | -------------- | -------- |
| 镜像标签   | WordPress 版本 | `latest` |
| 服务端口   | Web 服务端口   | `80`     |
| 资源限制   | CPU 和内存限制 | 见下文   |
| 持久化存储 | 数据存储配置   | 见下文   |

### 资源配置

- CPU 限制: 500m（相当于 0.5 核心）
- 内存限制: 512Mi（相当于 512MB）
- CPU 请求: 200m（相当于 0.2 核心）
- 内存请求: 256Mi（相当于 256MB）

### 持久化存储配置

- 启用持久化: true（建议开启）
- 挂载路径: /var/www/html
- 存储大小: 5Gi（可根据需求调整）
- 存储类: local（取决于集群环境）

## 数据存储

WordPress 的数据默认存储在容器的 `/var/www/html` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，生产环境建议至少 5Gi。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：

   - Web 界面：访问服务的 80 端口

2. 首次访问时，请完成初始化设置：

   - 选择语言
   - 设置站点标题
   - 创建管理员账号和密码
   - 配置数据库连接信息

3. 网站管理：
   - 登录管理后台可进行内容创建和编辑
   - 安装和配置主题和插件
   - 管理用户和评论

## 数据库配置

WordPress 需要一个 MySQL 或 MariaDB 数据库。您可以：

1. 使用现有数据库：在初始化向导中提供连接信息
2. 部署新的数据库：可以同时部署 MySQL 服务

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用更严格的网络访问控制
- 定期更新 WordPress 核心、主题和插件
- 定期备份网站内容和数据库
- 配置适当的资源限制，防止资源滥用

## 故障排除

1. 无法访问 Web 界面：

   - 检查服务是否正常运行
   - 确认网络连接是否畅通
   - 检查容器日志

2. 数据库连接问题：

   - 验证数据库服务是否可用
   - 确认数据库连接信息是否正确
   - 检查数据库用户权限

3. 持久化问题：
   - 确认 PVC 已正确创建并绑定
   - 检查存储类是否可用
   - 验证存储容量是否足够

