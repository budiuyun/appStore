# wireguard-easy

最简单的方式在任何Linux主机上安装和管理WireGuard

## 应用介绍

本应用提供以下功能：
- 一体化解决方案：WireGuard + Web UI
- 简易安装和使用：通过Docker快速部署
- 全面的客户端管理：列表、创建、编辑、删除、启用/禁用客户端
- 便捷的配置分享：显示客户端QR码、下载配置文件
- 实时监控：连接状态统计、传输/接收图表
- 多种高级功能：多语言支持、一次性链接、客户端过期、2FA支持等

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `weejewel/wg-easy` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `1Gi` |
| env | 环境变量配置 | 见下文 |

## 环境变量

应用程序支持以下环境变量配置：

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| WG_HOST | WireGuard服务器域名 | `` |
| PASSWORD_HASH | Web界面访问密码的bcrypt哈希值 | `` |
| WG_PERSISTENT_KEEPALIVE | WireGuard持久保活间隔(秒) | `25` |
| WG_DEFAULT_ADDRESS | 客户端默认IP地址范围 | `192.168.10.x` |
| WG_ALLOWED_IPS | 允许访问的IP范围 | `192.168.10.0/24` |
| INSECURE | 是否允许HTTP访问Web界面(不推荐) | `false` |

### 生成密码哈希

最新版本的WireGuard Easy要求使用PASSWORD_HASH而不是明文PASSWORD。您可以使用以下方法生成bcrypt哈希：

1. 使用在线工具：访问 https://bcrypt-generator.com/ 生成密码哈希

2. 使用Node.js生成：
```bash
# 安装bcrypt
npm install -g bcrypt-cli

# 生成哈希（替换'your_password'为您的密码）
bcrypt 'your_password'
```

3. 使用Python生成：
```bash
# 安装bcrypt
pip install bcrypt

# 运行Python生成哈希
python -c "import bcrypt; print(bcrypt.hashpw('your_password'.encode(), bcrypt.gensalt()).decode())"
```

生成的哈希应该类似于：`$2a$10$TGdkj8VaQT4TUU0uUdW2OeAjPPF3Ulllzof9Ec1BpJPKZgMYdYhvK`

## 数据存储

WireGuard Easy的配置数据存储在容器的 `/etc/wireguard` 目录中。启用持久化存储后，数据将保存在持久卷中，即使容器重启也不会丢失。

**提示**：请确保分配足够的存储空间，特别是如果您计划管理大量客户端。
## 安装WireGuard

需要安装WireGuard，可以按照以下步骤操作：

```bash
# 安装 WireGuard
sudo apt update
sudo apt install -y wireguard

# 安装 resolvconf
sudo apt install -y resolvconf

# 启动 resolvconf 服务
sudo systemctl enable --now resolvconf.service

# 启动 WireGuard
sudo wg-quick up /root/wg0.conf

# 关闭 WireGuard
sudo wg-quick down /root/wg0.conf

# 重启 WireGuard
sudo wg-quick down /root/wg0.conf && sudo wg-quick up /root/wg0.conf
```

### 设置开机自启

```bash
# 创建 systemd 服务文件 - 如果配置文件是 /root/wg0.conf
cat > /etc/systemd/system/wg-quick@wg0.service << EOF
[Unit]
Description=WireGuard via wg-quick(8) for %I
After=network-online.target nss-lookup.target
Wants=network-online.target nss-lookup.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/wg-quick up /root/wg0.conf
ExecStop=/usr/bin/wg-quick down /root/wg0.conf

[Install]
WantedBy=multi-user.target
EOF

# 启用服务使其开机自启
systemctl enable wg-quick@wg0.service
```

## 安全注意事项

- 生产环境中请设置强密码
- 使用HTTPS保护Web UI访问
- 定期更新WireGuard和WireGuard Easy
- 考虑启用2FA增强安全性
- 使用客户端过期功能管理临时访问权限