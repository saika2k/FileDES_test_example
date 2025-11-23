<h1 align="center">FileDES测试样例</h1>

本代码是FileDES系统的测试样例。本文件介绍如何在本地部署FileDES以及如何测试一个多版本文件的聚合证明验证时间（该文件具有4个版本）。

## FileDES部署
**系统与软件依赖安装**:

FileDES在Ubuntu22.04上进行开发和测试。为了正确部署FileDES需要通过下面的命令安装如下软件依赖

Ubuntu:
```bash
sudo apt install openjdk-17-jdk openjdk-17-jre mesa-opencl-icd ocl-icd-opencl-dev gcc git bzr jq pkg-config curl clang build-essential hwloc libhwloc-dev wget -y && sudo apt upgrade -y
```

**Go语言安装**

FileDES以Go语言进行开发，为了正确编译FileDES，需要安装Go语言（在开发时使用的是Go 1.18.1版本，建议安装相同版本，如果安装更新的版本可能会在编译时出现错误）

```bash
wget -c https://golang.org/dl/go1.18.1.linux-amd64.tar.gz -O - | sudo tar -xz -C /usr/local
```

**TIP:**
在安装完Go语言后需要将GOBIN加入路径，可以通过下面的命令实现：

```bash
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc && source ~/.bashrc
```

**编译FileDES**
在安装完所有软件依赖和Go语言后，即可通过下面的命令对FileDES进行编译：
```bash
make debug
```
该命令将构建FileDES的所有组件，由于FileDES是基于Filecoin的lotus开发，这些组件以lotus开头命名。(lotus, lotus-fountain, lotus-gateway, lotus-miner, lotus-seed, lotus-shed, lotus-stats, lotus-wallet and lotus-worker)另外如果是首次编译FileDES，由于其需要下载相关参数，编译过程可能会比较慢。

### 多版本文件聚合证明测试样例

目前本代码只提供了对于具有4个版本的多版本文件生成聚合证明的测试功能，后续将对该功能进行完善。
目前代码的scripts_FileDES中提供了启动脚本（run.sh）和多版本文件测试脚本（multi_files_test.sh）。测试文件在testdata文件夹下，是一个初始版本的ppt文件（v1.pptx）和三个通过bsdiff命令生成的增量文件（v1+patch1=v2.pptx,v1+patch1+patch2=v3.pptx,v1+patch1+patch2+patch3=v4.pptx）。要进行测试，需要在FileDES目录下运行下面两条指令：
```bash
bash scripts_FileDES/run.sh
```
等待该命令运行完成后，会在本地启动一个FileDES客户端（client）和FileDES服务器（miner），此时可以运行以下命令：
```bash
bash scripts_FileDES/multi_files_test.sh
```
该命令会上传初始版本的ppt文件和三个增量文件，并最终生成文件Verify_Agg，包含本次聚合证明验证的时间。
由于FileDES以Filecoin的原生代码为基础进行开发，本代码也会运行Filecoin原生的证明生成过程，因此运行速度较慢。

**TIP:**
在运行过程中可以通过下面的命令查看FileDES服务器处理文件的状态信息：
```bash
./lotus-miner sectors list
```
### 停止运行
可通过以下指令停止FileDES运行：
```bash
./lotus-miner stop
./lotus daemon stop
```
