# 广告在线制作

广告在线制作应用，基于Layui框架开发，提供简单易用的广告设计和制作功能。

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- 使用Deployment工作负载类型可确保应用程序的高可用性和易于扩展

## 参数

| 参数                | 描述               | 默认值         |
|---|-----|---|
| replicaCount        | 副本数量           | `1`           |
| workloadType        | 工作负载类型       | `Deployment`  |
| image.repository    | 镜像名称           | `niehaoran/layui-app`   |
| image.tag           | 镜像标签           | `latest`      |
| image.pullPolicy    | 镜像拉取策略       | `IfNotPresent`|
| service.type        | 服务类型           | `ClusterIP`   |
| persistence.enabled | 是否启用持久化存储 | `false`       |

## 介绍
layui-app是一款基于Layui框架开发的广告在线制作工具，具有以下特点：
- 简洁易用的广告设计界面
- 丰富的模板和素材库
- 支持多种广告格式的导出
- 实时预览功能
- 协同编辑能力

## 使用说明
### 初始设置
1. 部署完成后，通过浏览器访问应用
2. 首次使用可直接进入应用主界面
3. 开始创建新的广告项目

### 访问方式
应用默认通过80端口提供Web服务

### 常见配置
应用采用默认配置即可正常运行，无需额外配置环境变量

### 图片介绍
[截图](https://images.budiuyun.net/i/2025/06/19/6853ed30480c0.png)