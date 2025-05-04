#!/bin/bash

# 此脚本用于手动更新应用目录
# 执行方式: ./update-catalog.sh

echo "开始更新应用目录..."

# 执行目录生成脚本
bash ./generate-catalog.sh

# 检查是否成功生成
if [ -f "./app-catalog.md" ]; then
    echo "✅ 应用目录已成功生成: ./app-catalog.md"
    echo "应用分类统计:"
    grep -c "^##" ./app-catalog.md | xargs echo "- 分类总数:"
    grep -c "^\-" ./app-catalog.md | xargs echo "- 应用总数:"
else
    echo "❌ 应用目录生成失败"
    exit 1
fi

echo ""
echo "提示: 您可以通过部署 catalog-generator Chart 来自动更新目录"
echo "      helm install catalog-generator ./catalog-generator" 