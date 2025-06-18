# astrbot

松耦合、异步、支持多消息平台部署、具有易用的插件系统和完善的大语言模型（LLM）接入功能的聊天机器人及开发框架

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `soulter/astrbot` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | Web服务端口 | `8080` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `5Gi` |

## 环境变量

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| ADMIN_PASSWORD | 管理员密码，请务必修改 | `astrbot` |

## 持久化存储

AstrBot的数据默认存储在容器的 `/app/data` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

AstrBot 是一个松耦合、异步、支持多消息平台部署、具有易用的插件系统和完善的大语言模型（LLM）接入功能的聊天机器人及开发框架。

## 主要功能

- **大语言模型对话**：支持各种大语言模型，包括 OpenAI API、Google Gemini、Llama、Deepseek、ChatGLM 等，支持接入本地部署的大模型，通过 Ollama、LLMTuner。具有多轮对话、人格情境、多模态能力，支持图片理解、语音转文字（Whisper）。

- **多消息平台接入**：支持接入 QQ（OneBot）、QQ 频道、微信（Gewechat）、飞书、Telegram。支持速率限制、白名单、关键词过滤、百度内容审核。

- **Agent**：原生支持部分 Agent 能力，如代码执行器、自然语言待办、网页搜索。对接 Dify 平台，便捷接入 Dify 智能助手、知识库和 Dify 工作流。

- **插件扩展**：深度优化的插件机制，支持开发插件扩展功能，极简开发。已支持安装多个插件。

- **可视化管理面板**：支持可视化修改配置、插件管理、日志查看等功能，降低配置难度。集成 WebChat，可在面板上与大模型对话。

- **高稳定性、高模块化**：基于事件总线和流水线的架构设计，高度模块化，低耦合。

- **知识库能力**：自带知识库功能，支持导入外部知识并进行问答。

## 消息平台支持

- ✔ QQ(官方机器人接口)：私聊、群聊，QQ频道私聊、群聊
- ✔ QQ(OneBot)：私聊、群聊
- ✔ 微信个人号：微信个人号私聊、群聊
- ✔ Telegram：私聊、群聊
- ✔ 企业微信：私聊
- ✔ 微信客服：私聊
- ✔ 飞书：私聊、群聊
- ✔ 钉钉：私聊、群聊

## 注意事项

- 请务必修改默认密码以及保证 AstrBot 版本 >= 3.5.13
- WebUI默认用户名和密码均为：astrbot

## 相关链接

- 项目主页：https://github.com/Soulter/AstrBot
- WebUI在线体验：https://demo.astrbot.app/