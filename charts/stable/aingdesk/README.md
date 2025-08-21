# aingdesk

AingDesk 服务端，远程桌面管理解决方案

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `aingdesk/aingdesk` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `5Gi` |




# AingDesk

[English](README.md)

AingDesk是一款简单好用的AI助手，支持知识库、模型API、分享、联网搜索、智能体，它还在飞快成长中。

## 🚀一句话简介

简单好用的AI助手软件，支持本地AI模型及API+知识库搭建。

## ✅核心功能

- 一键部署本地AI模型及主流模型API
- 本地知识库
- 智能体创建
- 可在线分享给他人使用
- 支持联网搜索

- 支持服务器端部署
- 单次多模型同时对话（即将上线） 

## ✨产品亮点

- 简单好用，对AI新手友好

## 📥快速安装

### 客户端版本（MacOS, Windows）
- [官网下载](https://www.aingdesk.com/)   
- [从 CNB 下载](https://cnb.cool/aingdesk/AingDesk/-/releases/) 
- [从 Github 下载](https://github.com/aingdesk/AingDesk/releases)  
