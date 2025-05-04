# 应用目录生成器

此Chart用于自动生成应用目录，按照应用的分类组织展示所有可用的Helm应用。

## 功能介绍

- 自动扫描所有Chart.yaml文件，提取其中的分类信息（`budiu/app-category-zh`注解）
- 按照分类生成目录结构，便于用户浏览
- 提供应用名称和简短描述，并链接到对应应用
- 可作为Helm Hook自动运行，也可手动执行

## 使用方法

### 方法一：通过Helm安装

```bash
# 安装或更新时会自动生成目录
helm install catalog-generator ./catalog-generator \
  --set chartsPath=/path/to/your/charts

# 更新
helm upgrade catalog-generator ./catalog-generator
```

### 方法二：手动运行

```bash
# 直接执行脚本生成目录
cd /path/to/your/charts
bash ./update-catalog.sh
```

## 配置选项

| 参数 | 描述 | 默认值 |
|------|------|--------|
| `chartsPath` | Charts目录路径 | `/charts` |
| `outputPath` | 输出文件路径 | `/charts/app-catalog.md` |

## 目录结构

生成的目录文件包含以下内容：

1. 标题和生成时间
2. 分类快速导航
3. 按分类组织的应用列表，每个应用包含名称和描述

## 注意事项

- 确保每个Chart的Chart.yaml文件中都有正确的annotations部分
- 如果没有找到分类注解，应用将被归类为"其他"
- 建议定期运行该工具，保持目录的更新 