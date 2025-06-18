# chatgpt-next-web

一键免费部署你的私人ChatGPT网页应用

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `yidadaa/chatgpt-next-web` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | Web服务端口 | `3000` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `1Gi` |

## 环境变量

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| OPENAI_API_KEY | OpenAI API密钥，用于访问ChatGPT API | `` |
| CODE | 访问密码，用于保护您的应用 | `` |
| BASE_URL | API请求的基本URL | `https://api.openai.com` |

## 持久化存储

ChatGPT-Next-Web的数据默认存储在容器的 `/app/data` 目录中。启用持久化存储后，应用的配置和对话数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

ChatGPT-Next-Web是一个开源项目，允许用户一键部署私人的ChatGPT网页应用。它提供了与官方ChatGPT网站相似的用户体验，但可以使用您自己的API密钥，享有更高的速度和更稳定的服务。

主要功能包括：
- 精美的响应式UI设计，支持深色模式
- 流式回复，实时显示AI回复内容
- 支持自定义提示词和会话管理
- 完整的Markdown和代码高亮支持
- 支持保存对话历史
- 多语言支持
- PWA支持，可作为独立应用安装
- 提供API代理功能，解决区域限制问题

## 使用说明

### 必要的环境变量

在部署应用时，必须设置以下环境变量：

1. **OPENAI_API_KEY** - 您的OpenAI API密钥，用于访问ChatGPT API
2. **CODE** (可选) - 访问密码，设置后访问网页需要输入此密码

### 部署示例

```bash
docker run -d -p 3000:3000 \
   -e OPENAI_API_KEY="sk-xxxxx" \
   -e CODE="访问密码" \
   yidadaa/chatgpt-next-web
```

### 高级配置

- **BASE_URL** - 可以设置为自定义API端点，默认为OpenAI官方API
- **PROXY_URL** - 如需使用代理访问API，可设置此变量

## 相关链接

- 官方仓库：https://github.com/Yidadaa/ChatGPT-Next-Web
- Docker镜像：https://hub.docker.com/r/yidadaa/chatgpt-next-web