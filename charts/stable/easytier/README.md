# EasyTier Helm Chart

EasyTier 是一款简单、安全、去中心化的内网穿透和异地组网工具，适合远程办公、异地访问、游戏加速等多种场景。

## 功能特性

- 🚀 去中心化组网，无需公网 IP
- 🔒 支持 WireGuard 和 AES-GCM 加密
- 🌐 跨平台支持 (Linux, Windows, macOS, FreeBSD, Android)
- 📡 支持多种协议：TCP, UDP, WireGuard, WebSocket, WSS
- 🎮 游戏加速和联机支持
- 🔧 支持配置文件自定义

## 安装

### 添加 Helm 仓库

```bash
helm repo add easytier https://your-repo-url
helm repo update
```

### 安装 Chart

```bash
helm install easytier easytier/easytier
```

### 自定义配置安装

```bash
helm install easytier easytier/easytier \
  --set easytier.networkName="my-network" \
  --set easytier.networkSecret="my-secret" \
  --set easytier.ports.tcp=11010 \
  --set easytier.ports.udp=11010 \
  --set easytier.ports.wireguard=11011 \
  --set easytier.ports.websocket=11011 \
  --set easytier.ports.wss=11012
```

## 配置说明

### 端口配置

EasyTier 支持多种协议和端口：

```yaml
easytier:
  ports:
    tcp: 11010        # TCP 监听端口
    udp: 11010        # UDP 监听端口  
    wireguard: 11011  # WireGuard 监听端口
    websocket: 11011  # WebSocket 监听端口
    wss: 11012        # WSS (WebSocket Secure) 监听端口
```

### 网络配置

```yaml
easytier:
  networkName: "your-network-name"    # 网络名称
  networkSecret: "your-network-secret" # 网络密钥
  publicNode: ""                       # 公共节点地址（可选）
  daemon: true                         # 守护进程模式
```

### 服务端口

服务会自动暴露所有配置的端口：

- `11010/TCP` - EasyTier TCP 服务
- `11010/UDP` - EasyTier UDP 服务  
- `11011/TCP` - WireGuard 和 WebSocket 服务
- `11012/TCP` - WSS 服务

## 使用方法

### 1. 配置网络参数

编辑 `values.yaml` 文件，设置你的网络名称和密钥：

```yaml
easytier:
  networkName: "my-home-network"
  networkSecret: "my-secret-key"
```

### 2. 自定义端口（可选）

如果需要修改默认端口：

```yaml
easytier:
  ports:
    tcp: 12010        # 修改 TCP 端口
    udp: 12010        # 修改 UDP 端口
    wireguard: 12011  # 修改 WireGuard 端口
    websocket: 12011  # 修改 WebSocket 端口
    wss: 12012        # 修改 WSS 端口
```

### 3. 部署

```bash
helm upgrade --install easytier easytier/easytier -f values.yaml
```

### 4. 客户端连接

使用 EasyTier 客户端连接到你的网络：

```bash
# 使用网络名称和密钥连接
easytier-core --network-name "my-home-network" --network-secret "my-secret-key"
```

## 故障排除

### 端口冲突

如果遇到端口冲突，可以修改端口配置：

```yaml
easytier:
  ports:
    tcp: 12010        # 使用不同的端口
    udp: 12010
    wireguard: 12011
    websocket: 12011
    wss: 12012
```

### 连接错误

常见的连接错误及解决方案：

1. **"InvalidPacket("body too long")"** - 检查端口配置和网络设置
2. **连接超时** - 确认防火墙设置和端口开放
3. **认证失败** - 检查网络名称和密钥是否正确

### 查看日志

```bash
kubectl logs -f deployment/easytier
```

## 高级配置

### 自定义命令行参数

```yaml
easytier:
  extraArgs:
    - "--log-level=debug"
    - "--max-connections=1000"
```

### 资源限制

```yaml
resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 200m
    memory: 256Mi
```

### 持久化存储

```yaml
persistence:
  enabled: true
  size: 2Gi
  storageClass: "local"
  mounts:
    - /root
    - /etc/easytier
```

## 支持

- 📖 [官方文档](https://easytier.cn)
- 🐛 [问题反馈](https://github.com/EasyTier/EasyTier/issues)
- 💬 [社区讨论](https://github.com/EasyTier/EasyTier/discussions)

## 许可证

本项目基于 Apache License 2.0 许可证开源。 