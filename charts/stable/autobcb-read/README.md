# 轻阅读服务

轻阅读是一个Java开发的阅读应用，本Chart提供了在Kubernetes上部署轻阅读服务的配置。

## Docker 一键部署

使用 Docker 可以快速部署轻阅读服务，无需手动安装 Java 环境。

### 1. 安装 Docker
1. Windows/macOS：下载并安装 Docker Desktop
2. Linux：使用包管理器安装 Docker
   - Ubuntu/Debian：`sudo apt-get install docker.io`
   - CentOS：`sudo yum install docker`

### 2. 拉取镜像并运行
拉取最新镜像：
```bash
docker pull docker-0.unsee.tech/bitnami/java
```

运行容器：
```bash
docker run -tid -e TZ=Asia/Shanghai --name read -v /root/read:/app -p 8080:8080 --restart=always docker-0.unsee.tech/bitnami/java java -jar /app/read.jar
```

### 3. 参数说明
- `-tid`：后台运行并分配伪终端
- `-e TZ=Asia/Shanghai`：设置时区为上海
- `--name read`：容器名称
- `-v /root/read:/app`：数据持久化（主机目录:容器目录）
- `-p 8080:8080`：端口映射（主机端口:容器端口）
- `--restart=always`：容器退出时自动重启

### 4. 代理设置（可选）
如果需要使用代理，可以将启动命令修改为：
```bash
docker run -tid -e TZ=Asia/Shanghai --name read -v /root/read:/app -p 8080:8080 --restart=always docker-0.unsee.tech/bitnami/java java -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=1080 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=1080 -jar /app/read.jar
```

### 5. 常用命令
- 查看日志：`docker logs read`
- 停止服务：`docker stop read`
- 启动服务：`docker start read`
- 重启服务：`docker restart read`
- 删除容器：`docker rm read`

## Helm Chart 配置

### 默认配置

```yaml
workloadType: Deployment
replicaCount: 1
image:
  imageRegistry: docker-0.unsee.tech
  repository: bitnami/java
  tag: latest
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  ports:
    - name: http
      port: 8080
      protocol: TCP
persistence:
  enabled: true
  size: 5Gi
  accessMode: ReadWriteOnce
  storageClass: local
  mounts:
    - /app
command:
  enabled: true
  value: "java -jar /app/read.jar"
``` 