# lsky-pro

兰空图床 - 简单优雅的图片托管程序

## 应用介绍

本应用提供以下功能：
- 兰空图床 (Lsky Pro)：专业的图片托管和分享平台
- 支持多种存储方式：本地存储、对象存储等
- 简洁美观的界面：便捷的图片管理体验
- 支持持久化存储：确保图片数据安全

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 镜像标签 | Lsky Pro版本 | `latest` |
| 服务端口 | Web服务端口 | `8089` |
| 资源限制 | CPU和内存限制 | 见下文 |
| 持久化存储 | 数据存储配置 | 见下文 |

### 资源配置
- CPU限制: 300m（相当于0.3核心）
- 内存限制: 512Mi（相当于512MB）
- CPU请求: 100m（相当于0.1核心）
- 内存请求: 256Mi（相当于256MB）

### 持久化存储配置
- 启用持久化: true（建议开启）
- 挂载路径: /var/www/html/storage, /var/www/html/public/uploads
- 存储大小: 5Gi（可根据需求调整）
- 存储类: local（取决于集群环境）

## 数据存储

Lsky Pro的图片数据默认存储在容器的 `/var/www/html/public/uploads` 目录中，系统数据存储在 `/var/www/html/storage` 目录。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，生产环境建议至少 5Gi。

## 使用说明

1. 部署应用后，可通过以下方式访问服务：
   - Web界面：访问服务的80端口

2. 首次访问时，请完成初始化设置：
   - 设置管理员账号和密码
   - 配置站点基本信息
   - 选择存储方式

3. 图片上传和管理：
   - 登录后台可进行图片上传、管理和分享
   - 支持批量操作和图片分组

## 安全注意事项

- 生产环境中请设置强密码
- 考虑使用更严格的网络访问控制
- 定期备份图片和系统数据
- 配置适当的资源限制，防止资源滥用

## 故障排除

1. 无法访问Web界面：
   - 检查服务是否正常运行
   - 确认网络连接是否畅通
   - 检查容器日志
2. 图片上传失败：
   - 检查存储权限设置
   - 验证存储空间是否充足
   - 确认文件大小是否超过限制
3. 持久化问题：
   - 确认PVC已正确创建并绑定
   - 检查存储类是否可用
   - 验证存储容量是否足够