# cosyvoice

阿里开源 CosyVoice 语音合成/克隆，优化整合版

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `harryliu888/cosyvoice` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | Web服务端口 | `7860` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `10Gi` |

## 持久化存储

CosyVoice的数据默认存储在容器的 `/app/data` 目录中。启用持久化存储后，模型数据和用户生成的语音文件将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

CosyVoice是阿里巴巴开源的语音合成与克隆技术，本版本经过优化整合，提供更易用的体验。

主要功能包括：
- 语音合成：将文本转换为自然流畅的语音
- 语音克隆：根据少量语音样本复制指定声音特征
- Web界面：直观的操作界面，方便使用
- 多种声音风格：支持多种音色和情感表达
- 批处理能力：支持批量文本转语音处理
- 定制化选项：可调节语速、音调等参数
- 模型管理：支持导入/导出自定义语音模型
- 多语言支持：支持中文、英文等多种语言

## 相关链接

- 代码仓库：https://github.com/harryliu888/cosyvoice
- 原始项目：https://github.com/alibaba-damo-academy/CosyVoice