#!/bin/bash

# 手动创建和推送helm分支的脚本
# 说明：此脚本可供管理员使用，用于手动为特定用户创建helm分支
# 使用方法：./create-helm-branch.sh <用户名>

echo "====================================================="
echo "  Helm Chart 用户分支手动创建工具"
echo "  - 此工具用于为特定用户创建/更新helm分支"
echo "  - 仅供管理员维护使用"
echo "====================================================="

# 检查是否提供了用户名参数
if [ -z "$1" ]; then
  echo "错误: 请提供用户名作为参数"
  echo "用法: ./create-helm-branch.sh <用户名>"
  exit 1
fi

# 获取用户名参数
USER_NAME="$1"

# 检查当前是否在main分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ "$CURRENT_BRANCH" != "main" ]]; then
  echo "警告: 你当前不在main分支上，建议切换到main分支执行此脚本"
  echo "是否继续? (y/n)"
  read continue_answer
  if [[ "$continue_answer" != "y" && "$continue_answer" != "Y" ]]; then
    echo "操作已取消"
    exit 0
  fi
fi

# 设置目标分支名
TARGET_BRANCH="helm-$USER_NAME"
echo "用户名: $USER_NAME"
echo "目标Helm分支: $TARGET_BRANCH"

# 确认操作
echo 
echo "此操作将为用户 $USER_NAME 创建或更新分支 $TARGET_BRANCH"
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

# 创建README文件
echo "# Helm Repository for $USER_NAME" > README.md
echo "Generated manually by admin" >> README.md
echo "Owner: $USER_NAME" >> README.md
echo "Last updated: $(date)" >> README.md
echo "" >> README.md
echo "## Usage" >> README.md
echo '```bash' >> README.md
echo "# Add this Helm repository" >> README.md
echo "helm repo add $USER_NAME-repo https://raw.githubusercontent.com/\$REPO_OWNER/\$REPO_NAME/$TARGET_BRANCH/" >> README.md
echo "# Update repositories" >> README.md
echo "helm repo update" >> README.md
echo "# List available charts" >> README.md
echo "helm search repo $USER_NAME-repo" >> README.md
echo '```' >> README.md

# 提交并推送
echo "提交并推送..."
git add *.tgz index.yaml README.md
git commit -m "Update Helm charts for user $USER_NAME (manual)"
git push -f origin $TARGET_BRANCH

# 返回原分支
echo "返回原分支 $CURRENT_BRANCH..."
git checkout $CURRENT_BRANCH
git stash pop || true

# 计算仓库URL
REPO_URL=$(git config --get remote.origin.url | sed -E 's|.*github.com[:/](.*).git|\1|')
APP_REPO_URL="https://raw.githubusercontent.com/$REPO_URL/$TARGET_BRANCH/"

echo "====================================================="
echo "完成! 用户 $USER_NAME 的分支 $TARGET_BRANCH 已创建/更新"
echo "包含所有打包好的Charts和index.yaml"
echo "====================================================="
echo "应用仓库URL:"
echo "$APP_REPO_URL"
echo "====================================================="
echo "使用说明:"
echo "1. 复制上面的URL"
echo "2. 在容器平台中添加应用仓库"
echo "3. 使用上述URL作为仓库地址"
echo "=====================================================" 