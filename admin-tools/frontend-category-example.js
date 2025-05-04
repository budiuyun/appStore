/**
 * 不丢云应用商店分类系统使用示例
 * 这是一个示例代码，展示如何在前端获取和使用应用分类信息
 */

// 定义仓库基础URL（需要替换为实际URL）
const REPO_BASE_URL = 'https://your-helm-repo-url.com';

/**
 * 获取分类索引
 * @returns {Promise<Object>} 包含分类信息的对象
 */
async function fetchCategoryIndex() {
  try {
    const response = await fetch(`${REPO_BASE_URL}/category-index.json`);
    
    if (!response.ok) {
      throw new Error(`HTTP错误: ${response.status}`);
    }
    
    const data = await response.json();
    console.log('成功获取分类索引:', data);
    return data;
  } catch (error) {
    console.error('获取分类索引失败:', error);
    // 返回空分类数据作为后备
    return { categories: [], generated: new Date().toISOString() };
  }
}

/**
 * 根据应用名称获取分类
 * @param {String} appName 应用名称
 * @param {Array} categoryIndex 分类索引数据
 * @returns {String} 应用分类
 */
function getAppCategory(appName, categoryIndex) {
  if (!categoryIndex || !categoryIndex.categories) {
    return '未分类';
  }
  
  const appInfo = categoryIndex.categories.find(item => item.name === appName);
  return appInfo ? appInfo.category : '未分类';
}

/**
 * 获取所有可用分类
 * @param {Array} categoryIndex 分类索引数据
 * @returns {Array} 所有唯一分类的数组
 */
function getAllCategories(categoryIndex) {
  if (!categoryIndex || !categoryIndex.categories) {
    return ['未分类'];
  }
  
  // 获取所有分类并去重
  const categories = new Set();
  categoryIndex.categories.forEach(item => {
    if (item.category) {
      categories.add(item.category);
    }
  });
  
  // 转换为数组并添加"全部"和"未分类"选项
  return ['全部', ...Array.from(categories), '未分类'];
}

/**
 * 按分类筛选应用
 * @param {Array} apps 应用列表
 * @param {String} category 要筛选的分类
 * @param {Array} categoryIndex 分类索引数据
 * @returns {Array} 筛选后的应用列表
 */
function filterAppsByCategory(apps, category, categoryIndex) {
  if (category === '全部') {
    return apps;
  }
  
  return apps.filter(app => {
    const appCategory = getAppCategory(app.name, categoryIndex);
    return category === appCategory;
  });
}

/**
 * 使用示例
 */
async function exampleUsage() {
  // 1. 获取分类索引
  const categoryIndex = await fetchCategoryIndex();
  
  // 2. 获取所有可用分类
  const allCategories = getAllCategories(categoryIndex);
  console.log('所有分类:', allCategories);
  
  // 3. 模拟应用列表
  const mockApps = [
    { name: 'mysql', version: '1.0.0', description: 'MySQL数据库' },
    { name: 'uptime-kuma', version: '1.0.0', description: '监控工具' },
    { name: 'wordpress', version: '1.0.0', description: '博客系统' }
  ];
  
  // 4. 获取特定应用的分类
  console.log('MySQL分类:', getAppCategory('mysql', categoryIndex));
  
  // 5. 按分类筛选应用
  const databaseApps = filterAppsByCategory(mockApps, '数据库', categoryIndex);
  console.log('数据库类应用:', databaseApps);
}

// 运行示例
// exampleUsage(); 