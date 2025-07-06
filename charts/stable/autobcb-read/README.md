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
    http: 8080
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

## 持久卷和JAR文件说明

本Chart使用持久卷来存储应用数据。首次部署时，会自动创建一个初始化容器来处理持久卷的初始化：

1. 如果持久卷是空的，初始化容器会创建必要的目录结构
2. 初始化容器会在持久卷的/app目录中创建一个README.txt文件，提供上传说明
3. **重要：** 您需要手动上传实际的`read.jar`文件到持久卷中

### 容器行为

1. 如果容器启动时检测到`read.jar`文件不存在或为空：
   - 容器不会立即退出，而是进入等待状态
   - 日志中会显示错误信息和上传说明
   - 容器会每小时检查一次jar文件是否已上传
   - 这样设计可以让您有时间上传jar文件，而不需要重新部署

2. 当您上传了`read.jar`文件后：
   - 您可以重启Pod使应用立即启动
   - 或者等待下一次检查周期（最多1小时）

### 上传JAR文件

部署后，您需要将实际的`read.jar`文件上传到持久卷中。有几种方法可以实现：

1. 使用kubectl cp命令（推荐）：
```bash
# 获取Pod名称
kubectl get pods -n <namespace>

# 上传jar文件
kubectl cp /path/to/your/read.jar <pod-name>:/app/read.jar -n <namespace>
```

2. 使用Pod中的shell：
```bash
# 进入Pod
kubectl exec -it <pod-name> -n <namespace> -- bash

# 然后使用wget或curl下载jar文件
wget -O /app/read.jar http://your-server/path/to/read.jar
```

3. 直接挂载持久卷到主机，然后复制文件

上传完成后，重启Pod以立即应用更改：
```bash
kubectl rollout restart deployment <deployment-name> -n <namespace>
``` 