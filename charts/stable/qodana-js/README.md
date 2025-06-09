# qodana-js

JetBrains Qodana - JavaScript/TypeScript项目的代码质量分析工具

## 应用介绍

本应用提供以下功能：
- 静态代码分析：检测JavaScript和TypeScript代码中的问题
- 代码质量评估：提供代码质量指标和改进建议
- 智能检查：基于JetBrains IDE的智能代码分析能力
- 安全漏洞检测：识别潜在的安全问题
- 代码规范检查：确保代码符合最佳实践和团队规范
- 详细报告：生成可视化的分析报告

## 配置说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| 镜像标签 | Qodana版本 | `latest` |
| 服务端口 | Web服务端口 | `8080` |
| 资源限制 | CPU和内存限制 | 见下文 |
| 持久化存储 | 数据存储配置 | 见下文 |

### 资源配置
- CPU限制: 2000m（相当于2核心）
- 内存限制: 4Gi（相当于4GB）
- CPU请求: 1000m（相当于1核心）
- 内存请求: 2Gi（相当于2GB）

### 持久化存储配置
- 启用持久化: true（建议开启）
- 挂载路径: /data/project, /data/results
- 存储大小: 5Gi（可根据项目大小调整）
- 存储类: local（取决于集群环境）

## 数据存储

Qodana需要两个主要的存储路径：
1. `/data/project`：存放要分析的项目代码
2. `/data/results`：存放分析结果和报告

启用持久化存储后，这些数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：对于大型项目，可能需要增加存储空间大小。

## 使用说明

1. 部署应用后，准备要分析的代码：
   - 将JavaScript/TypeScript项目代码放入`/data/project`目录

2. 启动分析：
   - 分析会自动开始，或通过API触发
   - 分析过程可能需要几分钟到几小时，取决于项目大小

3. 查看报告：
   - 分析完成后，可在`/data/results`目录找到报告
   - 如果启用了`QODANA_SHOW_REPORT`，可通过Web界面查看报告

4. 集成Qodana Cloud：
   - 配置`QODANA_TOKEN`可将结果上传到Qodana Cloud
   - 在Qodana Cloud平台查看历史分析结果和趋势

## 环境变量配置

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| QODANA_PROJECT_DIR | 要分析的项目目录路径 | `/data/project` |
| QODANA_REPORT_DIR | 分析报告输出目录 | `/data/results` |
| QODANA_SHOW_REPORT | 是否在分析完成后显示报告 | `true` |
| QODANA_TOKEN | Qodana Cloud令牌 | `` |

## 高级配置

Qodana支持多种高级配置选项，可通过创建`qodana.yaml`配置文件实现：
