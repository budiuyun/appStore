# 轻阅读

轻阅读是一款开源的多平台阅读应用，支持多种书源、在线朗读和听书功能。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- 使用Deployment确保应用程序可以平稳更新和扩展，适合无状态应用程序部署

## 参数

| 参数                | 描述               | 默认值                  |
|---------------------|--------------------|------------------------|
| replicaCount        | 副本数量           | `1`                    |
| workloadType        | 工作负载类型       | `Deployment`           |
| image.imageRegistry | 镜像仓库           | `docker-0.unsee.tech`  |
| image.repository    | 镜像名称           | `bitnami/java`         |
| image.tag           | 镜像标签           | `latest`               |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`         |
| command             | 容器启动命令       | `["java"]`             |
| args                | 命令参数           | `["-jar", "/app/read.jar"]` |
| service.type        | 服务类型           | `ClusterIP`            |
| persistence.enabled | 是否启用持久化存储 | `true`                 |
| persistence.size    | 存储大小           | `2Gi`                  |
| env                 | 环境变量配置       | 见下文                 |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量        | 描述                 | 默认值          |
|-----------------|----------------------|----------------|
| TZ              | 时区设置             | `Asia/Shanghai`|
| JAVA_OPTS       | Java虚拟机参数       | ``             |
| http_proxyHost  | HTTP代理服务器地址   | ``             |
| http_proxyPort  | HTTP代理服务器端口   | ``             |
| https_proxyHost | HTTPS代理服务器地址  | ``             |
| https_proxyPort | HTTPS代理服务器端口  | ``             |

## 介绍
轻阅读是一款功能强大的开源阅读应用，提供以下核心功能：
- 多书源支持：可添加和管理多种网络书源
- 在线朗读：支持多种TTS引擎，可在线朗读小说内容
- 听书功能：支持音频播放和控制
- 多平台支持：可在移动设备和Web端使用
- 书籍缓存：支持离线阅读
- 自定义主题：提供多种阅读界面和主题
- 图片解密：支持图片解密功能

## 使用说明
1. 部署应用后，通过浏览器访问服务的8080端口
2. 首次使用时，需要添加书源或导入书源
3. 添加书籍到书架后，可以开始阅读
4. 应用支持以下功能：
   - 搜索书籍：支持单源和多源搜索
   - 阅读设置：字体大小、背景颜色、翻页效果等
   - 书籍缓存：可缓存书籍内容以便离线阅读
   - TTS朗读：支持在线和本地TTS引擎
   - 听书功能：支持音频播放控制

## 出处
轻阅读项目官方仓库：https://github.com/autobcb/read