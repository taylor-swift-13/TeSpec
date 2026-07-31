# TeSpec 离线 Docker 包

本目录包含完整 `linux/amd64` Docker image archive。目标机器不需要源码、
Python、QCP、Coq、SMT 或网络，只需要可运行 amd64 容器的 Docker Engine。

## 开箱自检

```bash
./load-and-test.sh
```

脚本会：

1. 校验压缩包和所有随附文件的 SHA-256；
2. 从本地压缩文件执行 `docker load`；
3. 核对镜像 ID 和平台；
4. 以 `--network none` 运行数组、闭合结构体、DLL、函数调用和 Coq proof
   checking 回归；
5. 挂载随附的新题示例，再次以 `--network none` 测试公开
   `analyze`、`run` 和 skill 接口。

看到 `TeSpec offline bundle test passed.` 才表示部署成功。

## 测试自己的题

进入题目目录后使用随附包装器：

```bash
/path/to/bundle/tespec analyze SOURCE.c \
  --function FUNCTION --write-binds binds.json

/path/to/bundle/tespec run SOURCE.c \
  --function FUNCTION --binds binds.json \
  --output-dir .spectest/run
```

包装器始终添加 `--network none`，并只把当前目录挂载到容器 `/work`。因此先
`cd` 到包含源码、binds 和题目本地依赖的共同目录。

查看 end-to-end skill：

```bash
/path/to/bundle/tespec skill tespec-e2e
/path/to/bundle/tespec skill tespec-artifacts
```

该 skill 驱动外部或本地大模型生成/修订 spec、每个 spec 生成 30 条 binds、产生
implementation mutants 并收集负例。镜像不包含模型权重，也不会偷偷联网调用
模型；确定性的 TeSpec 测试阶段完全离线。

## 保证边界

- 镜像运行不访问网络；自检使用 Docker 的 `--network none` 强制验证。
- Docker Engine 本身不在压缩包内。
- 镜像平台固定为 `linux/amd64`。
- 30 条测试只能证明这些具体输入没有违反最终 spec，不能替代普遍验证。
