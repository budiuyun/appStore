# mtab

多端同步、美观易用的在线导航和书签工具

## 应用介绍

本应用提供以下功能：
- 跨设备同步：在不同设备上同步您的书签和笔记
- 跨浏览器支持：适用于Chrome、Firefox、Edge、Safari等主流浏览器
- 多功能一体：书签管理、记事本和实用在线工具集成
- 私有部署：完全掌控您的数据，确保隐私安全
- 免费无广告：清爽的使用体验，没有任何干扰

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 镜像标签 | mTab版本 | `latest` |
| 服务端口 | Web服务端口 | `80` |
| 资源限制 | CPU和内存限制 | 见下文 |
| 持久化存储 | 数据存储配置 | 见下文 |

### 资源配置
- CPU限制: 300m（相当于0.3核心）
- 内存限制: 512Mi（相当于512MB）
- CPU请求: 100m（相当于0.1核心）
- 内存请求: 256Mi（相当于256MB）

### 持久化存储配置
- 启用持久化: true（建议开启）
- 挂载路径: /app
- 存储大小: 1Gi（可根据需求调整）
- 存储类: local（取决于集群环境）

## 数据存储

mTab的数据默认存储在容器的 `/app` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，特别是如果您计划存储大量书签和笔记。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：
   - Web界面：访问服务的80端口

2. 首次访问时，需要完成初始化设置：
   - 设置管理员账号和密码
   - 配置数据库连接信息
   - 设置站点基本信息

3. 功能使用：
   - 添加和管理书签
   - 创建和编辑笔记
   - 使用内置工具
   - 设置同步选项

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用Nginx反向代理或CDN，并配置SSL证书启用HTTPS
- 定期备份数据
- 配置适当的访问控制