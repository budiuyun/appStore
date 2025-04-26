#!/bin/bash

# 手动创建和推送helm分支的脚本
# 说明：此脚本可供所有仓库用户使用，用于创建和更新自己的helm分支
# 使用方法：确保你在自己的用户分支上，然后运行此脚本

echo "====================================================="
echo "  Helm Chart 分支自动创建工具"
echo "  - 此工具将为当前分支创建对应的helm-xxx分支"
echo "  - 所有用户均可使用此工具处理自己的分支"
echo "====================================================="

# 获取当前分支名
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 检查是否在main或helm-开头的分支上
if [[ "$CURRENT_BRANCH" == "main" || "$CURRENT_BRANCH" == "master" ]]; then
  echo "错误: 你当前在主分支上。请先创建并切换到你的用户分支。"
  echo "使用: git checkout -b 你的分支名"
  exit 1
fi

if [[ "$CURRENT_BRANCH" == helm-* ]]; then
  echo "错误: 你当前在helm-开头的分支上，这些分支名保留给系统使用。"
  echo "使用: git checkout -b 你的分支名 (不要以helm-开头)"
  exit 1
fi

# 设置目标分支名
TARGET_BRANCH="helm-$CURRENT_BRANCH"
echo "当前用户分支: $CURRENT_BRANCH"
echo "目标Helm分支: $TARGET_BRANCH"

# 确认操作
echo 
echo "此操作将创建或更新分支 $TARGET_BRANCH"
echo "确认继续? (y/n)"
read confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "操作已取消"
  exit 0
fi

# 创建输出目录
OUTPUT_DIR=".release"
mkdir -p $OUTPUT_DIR
echo "创建输出目录: $OUTPUT_DIR"

# 查找并打包所有的Chart
echo "开始打包Charts..."
for chart_dir in charts/stable/*/; do
  if [ -d "$chart_dir" ]; then
    echo "处理目录: $chart_dir"
    # 查找Chart.yaml文件
    find "$chart_dir" -name Chart.yaml -type f | while read chart_file; do
      chart_path=$(dirname "$chart_file")
      echo "找到Chart: $chart_path"
      helm package "$chart_path" -d "$OUTPUT_DIR" || echo "打包 $chart_path 失败"
    done
  fi
done

# 创建index.yaml
echo "创建index.yaml..."
cd $OUTPUT_DIR
helm repo index .
cd ..

# 保存当前状态
echo "保存当前状态..."
git stash

# 创建或切换到目标分支
echo "尝试切换到目标分支 $TARGET_BRANCH..."
git fetch origin $TARGET_BRANCH || true
if git show-ref --verify --quiet refs/remotes/origin/$TARGET_BRANCH; then
  echo "分支 $TARGET_BRANCH 已存在，切换到该分支"
  git checkout $TARGET_BRANCH
  git pull origin $TARGET_BRANCH
  # 清理现有文件
  rm -f *.tgz index.yaml
else
  echo "创建新分支 $TARGET_BRANCH"
  git checkout --orphan $TARGET_BRANCH
  git rm -rf .
fi

# 复制打包好的文件
echo "复制打包好的文件..."
cp -r $OUTPUT_DIR/* .

# 提交并推送
echo "提交并推送..."
git add *.tgz index.yaml
git commit -m "Update Helm charts for user branch $CURRENT_BRANCH"
git push -f origin $TARGET_BRANCH

# 返回原分支
echo "返回原分支 $CURRENT_BRANCH..."
git checkout $CURRENT_BRANCH
git stash pop || true

# 计算仓库URL
REPO_URL=$(git config --get remote.origin.url | sed -E 's|.*github.com[:/](.*).git|\1|')
APP_REPO_URL="https://raw.githubusercontent.com/$REPO_URL/$TARGET_BRANCH/"

echo "====================================================="
echo "完成! 分支 $TARGET_BRANCH 已创建/更新"
echo "包含所有打包好的Charts和index.yaml"
echo "====================================================="
echo "应用仓库URL:"
echo "$APP_REPO_URL"
echo "====================================================="
echo "使用说明:"
echo "1. 复制上面的URL"
echo "2. 在你的容器平台中添加应用仓库"
echo "3. 使用上述URL作为仓库地址"
echo "=====================================================" 