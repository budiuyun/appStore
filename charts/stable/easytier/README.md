# EasyTier

EasyTier是一个简单易用的内网穿透工具，支持多种协议和网络拓扑。

## 简介

EasyTier是一个基于Rust开发的内网穿透工具，具有以下特点：

- 简单易用：配置简单，一键连接
- 多协议支持：支持TCP、UDP、HTTP等协议
- 安全可靠：使用加密通信，保护数据传输安全
- 高性能：基于Rust开发，性能优异
- 跨平台：支持Windows、Linux、macOS等操作系统

## 安装

### 使用Helm安装

```bash
# 添加Helm仓库
helm repo add appstore https://your-repo-url

# 安装EasyTier
helm install easytier appstore/easytier \
  --set easytier.networkName="your-network-name" \
  --set easytier.networkSecret="your-network-secret"
```

### 手动安装

```bash
# 克隆仓库
git clone https://github.com/your-repo/appStore.git

# 进入EasyTier目录
cd appStore/charts/stable/easytier

# 安装
helm install easytier . \
  --set easytier.networkName="your-network-name" \
  --set easytier.networkSecret="your-network-secret"
```

## 配置

### 必需配置

- `easytier.networkName`: EasyTier网络名称
- `easytier.networkSecret`: EasyTier网络密钥

### 可选配置

- `easytier.publicNode`: 公共节点地址（如果不指定则使用默认节点）

### 默认账号信息

- **用户名**: admin
- **密码**: admin123

> 注意：为了安全起见，建议在生产环境中修改默认密码

### 可选配置

- `easytier.publicNode`: 公共节点地址（默认：tcp://public.easytier.cn:11010）
- `easytier.daemon`: 是否以守护进程模式运行（默认：true）
- `easytier.extraArgs`: 额外的命令行参数

### 完整配置示例

```yaml
easytier:
  networkName: "my-network"
  networkSecret: "my-secret"
  publicNode: ""  # 可选，如果不指定则使用默认节点
  daemon: true
  extraArgs: []

image:
  imageRegistry: docker.io
  repository: easytier/easytier
  tag: latest

service:
  type: ClusterIP
  ports:
    - name: easytier
      port: 11010
      protocol: TCP

# 环境变量配置（包含默认账号信息）
env:
  env1:
    name: TZ
    value: "Asia/Shanghai"
    description: 时区设置
    title: 时区
  env2:
    name: EASYTIER_ADMIN_USER
    value: "admin"
    description: 管理员用户名
    title: 管理员用户名
  env3:
    name: EASYTIER_ADMIN_PASSWORD
    value: "admin123"
    description: 管理员密码
    title: 管理员密码

persistence:
  enabled: true
  size: 1Gi
  accessMode: ReadWriteOnce
  storageClass: ""

security:
  privileged: true
  capabilities:
    - NET_ADMIN
    - NET_RAW

hostNetwork: true
```

## 使用方法

1. 获取EasyTier网络名称和密钥
2. 配置必需参数（网络名称和密钥）
3. 可选：配置公共节点地址（如果不配置则使用默认节点）
4. 部署到Kubernetes集群
5. 等待Pod启动完成
6. 检查日志确认连接状态
7. 使用默认账号admin/admin123登录管理界面

### 访问管理界面

部署完成后，您可以通过以下方式访问EasyTier管理界面：

```bash
# 端口转发到本地
kubectl port-forward service/easytier 11010:11010

# 在浏览器中访问
# http://localhost:11010
# 用户名: admin
# 密码: admin123
```

## 注意事项

- EasyTier需要特权模式运行以访问网络接口
- 需要主机网络模式以获取真实的网络接口
- 配置文件会持久化存储在PVC中
- 建议在生产环境中使用特定的存储类

## 故障排除

### 常见问题

1. **Pod无法启动**
   - 检查是否有足够的权限
   - 确认镜像是否正确拉取

2. **网络连接失败**
   - 检查网络名称和密钥是否正确
   - 确认公共节点是否可达

3. **权限不足**
   - 确认Pod运行在特权模式下
   - 检查是否有必要的网络权限

### 查看日志

```bash
# 查看Pod日志
kubectl logs -f deployment/easytier

# 查看Pod状态
kubectl get pods -l app.kubernetes.io/name=easytier
```

## 许可证

本项目采用MIT许可证。 