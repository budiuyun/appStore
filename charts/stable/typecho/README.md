# typecho

Typecho是一个轻量级的开源博客程序

## 应用介绍

本应用提供以下功能：
- 轻量级博客系统：占用资源少，运行高效
- 简洁优雅的界面：专注于内容创作和阅读体验
- 灵活的主题系统：支持自定义外观
- 强大的插件机制：可扩展功能
- 支持Markdown：便捷的内容编辑方式

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 镜像标签 | Typecho版本 | `nightly-php8.0-apache` |
| 服务端口 | Web服务端口 | `80` |
| 资源限制 | CPU和内存限制 | 见下文 |
| 持久化存储 | 数据存储配置 | 见下文 |

### 资源配置
- CPU限制: 300m（相当于0.3核心）
- 内存限制: 256Mi（相当于256MB）
- CPU请求: 100m（相当于0.1核心）
- 内存请求: 128Mi（相当于128MB）

### 持久化存储配置
- 启用持久化: true（建议开启）
- 挂载路径: /app/usr
- 存储大小: 1Gi（可根据需求调整）
- 存储类: local（取决于集群环境）

## 数据存储

Typecho的用户数据存储在容器的 `/app/usr` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，特别是如果您计划上传大量图片或附件。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：
   - Web界面：访问服务的80端口

2. 首次访问时，系统将自动完成初始化：
   - 使用环境变量中配置的管理员信息创建账号
   - 设置站点基本信息
   - 配置数据库连接

3. 博客管理：
   - 登录管理后台可进行内容创建和编辑
   - 安装和配置主题和插件
   - 管理评论和用户

## 环境变量配置

Typecho支持多种环境变量配置，主要包括：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| TIMEZONE | 服务器时区 | `Asia/Shanghai` |
| MEMORY_LIMIT | PHP内存限制 | `128M` |
| MAX_POST_BODY | 允许的最大POST请求大小 | `50M` |
| TYPECHO_INSTALL | 是否自动运行安装脚本 | `1` |
| TYPECHO_DB_ADAPTER | Typecho数据库驱动 | `Pdo_Mysql` |
| TYPECHO_DB_HOST | 数据库服务器地址 | `mysql` |
| TYPECHO_DB_PORT | 数据库服务器端口 | `3306` |
| TYPECHO_DB_USER | 数据库用户名 | `typecho` |
| TYPECHO_DB_PASSWORD | 数据库密码 | `typecho` |
| TYPECHO_DB_DATABASE | Typecho数据库名称 | `typecho` |
| TYPECHO_DB_PREFIX | 数据库表前缀 | `typecho_` |
| TYPECHO_SITE_URL | 您的网站URL | `https://example.com` |
| TYPECHO_USER_NAME | 管理员用户名 | `admin` |
| TYPECHO_USER_PASSWORD | 管理员密码 | `password` |
| TYPECHO_USER_MAIL | 管理员邮箱 | `admin@example.com` |

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用HTTPS保护用户数据
- 定期更新Typecho和插件
- 定期备份博客数据和数据库