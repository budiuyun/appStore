# 达不四API管理系统

达不四API管理系统v2.1

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- 使用Deployment工作负载类型可确保API管理系统的高可用性和易于扩展

## 参数

| 参数                | 描述               | 默认值         |
|---|-----|---|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `dabusapimanager`   |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| persistence.enabled | 是否启用持久化存储 | `true`        |
| persistence.size    | 存储大小           | `1Gi`         |

## 介绍
达不四API管理系统v2.1

## 使用说明
### 初始设置
1. 部署完成后，通过浏览器访问应用
2. 默认访问端口为80

### 访问方式
应用默认通过80端口提供Web服务

### 持久化存储
系统会挂载以下目录:
- `/var/www/html/config.php`: 配置文件
- `/var/www/html/uploads`: 上传文件目录

## 出处
达不四API管理系统v2.1

## 图片介绍
![达不四API管理系统1]https://images.budiuyun.net/i/2025/06/19/6853f4a080ec6.jpg
![达不四API管理系统2]https://images.budiuyun.net/i/2025/06/19/6853f4a0b49ee.jpg
![达不四API管理系统3]https://images.budiuyun.net/i/2025/06/19/6853f4a0f3d28.jpg
![达不四API管理系统4]https://images.budiuyun.net/i/2025/06/19/6853f4a1701b1.jpg