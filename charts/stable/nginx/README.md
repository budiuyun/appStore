# nginx

高性能Web服务器和反向代理

## 工作负载类型

此Helm Chart使用 `Deployment` 工作负载类型。

- Deployment适合无状态应用，方便快速扩展和更新

## 参数

| 参数 | 描述 | 默认值 |
|------|------|--------|
| replicaCount | 副本数量 | `1` |
| workloadType | 工作负载类型 | `Deployment` |
| image.repository | 镜像名称 | `nginx` |
| image.tag | 镜像标签 | `latest` |
| image.pullPolicy | 镜像拉取策略 | `IfNotPresent` |
| service.type | 服务类型 | `ClusterIP` |
| service.ports.http | HTTP端口 | `80` |
| service.ports.https | HTTPS端口 | `443` |
| persistence.enabled | 是否启用持久化存储 | `true` |
| persistence.size | 存储大小 | `1Gi` |

## 环境变量

| 环境变量 | 描述 | 默认值 |
|---------|------|--------|
| NGINX_ENVSUBST_TEMPLATE_DIR | 包含模板文件的目录 | `/etc/nginx/templates` |
| NGINX_ENVSUBST_TEMPLATE_SUFFIX | 模板文件的后缀 | `.template` |
| NGINX_ENTRYPOINT_QUIET_LOGS | 设置为1可以静默入口点日志输出 | `0` |

## 持久化存储

Nginx的数据默认存储在容器的多个目录中，包括：
- `/usr/share/nginx/html`：静态网站内容
- `/var/cache/nginx`：缓存数据
- `/var/log/nginx`：日志文件
- `/etc/nginx/conf.d`：配置文件

启用持久化存储后，这些目录中的数据将保存在持久卷中，即使容器重启也不会丢失。请根据实际需求分配合适的存储空间。

## 应用介绍

Nginx是一个开源的高性能Web服务器、反向代理服务器和负载均衡器。它以高并发、高性能、低内存消耗和高度可配置性而闻名，被广泛用于各种Web应用部署场景。

主要功能包括：
- HTTP/HTTPS服务器
- 反向代理服务器
- 负载均衡器
- HTTP缓存
- SSL/TLS终端
- 静态文件服务
- 自动压缩
- 高级流量管理

## 使用说明

### 基本配置

默认情况下，Nginx会使用位于`/etc/nginx/conf.d/default.conf`的配置文件和位于`/etc/nginx/nginx.conf`的主配置文件。您可以通过持久卷挂载自己的配置文件来覆盖默认配置。

### 静态内容托管

您可以将自己的静态内容放置在`/usr/share/nginx/html`目录下：

```bash
docker run -d -p 8080:80 -v /path/to/content:/usr/share/nginx/html:ro nginx
```

### 自定义配置

挂载自定义配置文件：

```bash
docker run -d -p 8080:80 -v /path/to/custom.conf:/etc/nginx/conf.d/default.conf:ro nginx
```

### 使用环境变量

从Nginx 1.19开始，支持在配置文件中使用环境变量。创建一个模板文件`/etc/nginx/templates/default.conf.template`：

```
server {
    listen       ${NGINX_PORT};
    server_name  ${NGINX_HOST};
    
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
}
```

然后设置相应的环境变量：

```bash
docker run -d -p 8080:80 -e NGINX_HOST=example.com -e NGINX_PORT=80 nginx
```

## 相关链接

- 官方网站：https://nginx.org/
- 文档：https://nginx.org/en/docs/
- Docker Hub：https://hub.docker.com/_/nginx