#!/bin/bash
# 测试分类生成器脚本

# 确保当前目录是项目根目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.." || exit 1

echo "=== 开始测试分类生成器 ==="

# 创建测试目录
TEST_DIR="test_charts"
mkdir -p "$TEST_DIR"

# 清理之前的测试文件
rm -rf "$TEST_DIR/category-index.json"

# 创建测试Chart文件
echo "创建测试Chart文件..."

mkdir -p "$TEST_DIR/mysql/templates"
cat > "$TEST_DIR/mysql/Chart.yaml" << EOF
apiVersion: v2
name: mysql
version: 1.0.0
description: "MySQL数据库服务"
icon: https://www.mysql.com/common/logos/logo-mysql-170x115.png
annotations:
  budiu/app-category-zh: "数据库"
EOF

mkdir -p "$TEST_DIR/uptime-kuma/templates"
cat > "$TEST_DIR/uptime-kuma/Chart.yaml" << EOF
apiVersion: v2
name: uptime-kuma
version: 1.0.0
description: "监控工具"
icon: https://example.com/uptime-kuma-icon.png
annotations:
  app-category-zh: "监控工具"
EOF

mkdir -p "$TEST_DIR/wordpress/templates"
cat > "$TEST_DIR/wordpress/Chart.yaml" << EOF
apiVersion: v2
name: wordpress
version: 1.0.0
description: "博客系统"
icon: https://example.com/wordpress-icon.png
# 这个没有分类标签
EOF

# 创建临时生成脚本副本
TEMP_SCRIPT="$TEST_DIR/temp-generate-category-index.sh"
cp "admin-tools/generate-category-index.sh" "$TEMP_SCRIPT"

# 修改临时脚本以使用测试目录
sed -i "s|find charts|find $TEST_DIR|g" "$TEMP_SCRIPT"
sed -i "s|OUTPUT_FILE=\"charts/category-index.json\"|OUTPUT_FILE=\"$TEST_DIR/category-index.json\"|g" "$TEMP_SCRIPT"

# 运行临时脚本
echo "运行分类生成器..."
chmod +x "$TEMP_SCRIPT"
"$TEMP_SCRIPT"

# 检查结果
echo ""
echo "=== 测试结果 ==="
if [ -f "$TEST_DIR/category-index.json" ]; then
    echo "✅ 成功生成分类索引文件"
    echo "内容预览:"
    cat "$TEST_DIR/category-index.json"
    
    # 检查是否包含正确的应用和分类
    if grep -q "\"name\": \"mysql\"" "$TEST_DIR/category-index.json" && 
       grep -q "\"category\": \"数据库\"" "$TEST_DIR/category-index.json"; then
        echo "✅ MySQL应用分类正确"
    else
        echo "❌ MySQL应用分类有误"
    fi
    
    if grep -q "\"name\": \"uptime-kuma\"" "$TEST_DIR/category-index.json" && 
       grep -q "\"category\": \"监控工具\"" "$TEST_DIR/category-index.json"; then
        echo "✅ uptime-kuma应用分类正确"
    else
        echo "❌ uptime-kuma应用分类有误"
    fi
else
    echo "❌ 分类索引文件生成失败"
fi

# 询问是否保留测试文件
read -p "是否保留测试文件? (y/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "清理测试文件..."
    rm -rf "$TEST_DIR"
fi

echo "测试完成" 