# Qinglong

## 简介

Qinglong(青龙)是一个支持 Python3、JavaScript、Shell、Typescript 的定时任务管理平台。具有在线编辑脚本、定时执行、日志查看、文件管理等功能。

## 主要功能

- 支持多种脚本语言
- 在线任务管理
- 定时执行
- 在线编辑器
- 文件管理
- 依赖管理
- 系统管理

## 配置说明

### 基础配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `replicaCount` | 副本数量 | `1` |
| `image.imageRegistry` | 镜像仓库 | `registry-2.yunna.net` |
| `image.repository` | 镜像名称 | `whyour/qinglong` |
| `image.tag` | 镜像标签 | `2.17.11` |

### 服务配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `service.type` | 服务类型 | `ClusterIP` |
| `service.port` | 容器端口 | `5700` |
| `service.externalPort` | 服务端口 | `80` |

### 资源配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `resources.limits.cpu` | CPU 限制 | `500m` |
| `resources.limits.memory` | 内存限制 | `1Gi` |
| `resources.requests.cpu` | CPU 请求 | `250m` |
| `resources.requests.memory` | 内存请求 | `512Mi` |

### 存储配置

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `persistence.enabled` | 启用持久化 | `true` |
| `persistence.path` | 挂载路径 | `/ql/data` |
| `persistence.size` | 存储大小 | `5Gi` |

## 使用说明

1. 部署后通过浏览器访问服务
2. 首次访问使用默认用户名和密码:
   - 用户名: admin
   - 密码: admin
3. 登录后请立即修改默认密码

## 故障排除

- 服务无法访问
  - 检查服务配置和端口设置
  - 确认网络策略
  
- 任务执行失败
  - 检查脚本权限
  - 查看执行日志
  
- 存储问题
  - 确认 PVC 创建状态
  - 检查存储卷挂载