# TeSpec 离线 Docker

正式离线交付物是预构建镜像包，不要求目标机 `docker build` 或访问镜像仓库。

## 离线机器

```bash
tar -xf tespec-offline-0.3.0-20260729-amd64.tar
cd tespec-offline-0.3.0-20260729-amd64
./load-and-test.sh
```

测试新题：

```bash
cd /path/to/problem
/path/to/tespec-offline-0.3.0-20260729-amd64/tespec \
  analyze source.c --function target --write-binds binds.json

/path/to/tespec-offline-0.3.0-20260729-amd64/tespec \
  run source.c --function target --binds binds.json \
  --output-dir .spectest/target
```

包装器固定使用 `--network none`，当前题目目录挂载为 `/work`。题目的 `.v`、
headers 和 strategies 应与题目一起放在该目录下。

## End-to-end skill

```bash
/path/to/bundle/tespec skill tespec-e2e
/path/to/bundle/tespec skill tespec-four-class
/path/to/bundle/tespec skill tespec-artifacts
```

skill 要求模型：

1. 参考镜像 `cases/` 中相似程序，在实现副本上生成或修正 QCP spec；
2. 每个 spec 生成并验证恰好 30 条 binds；
3. 在原实现 30/30 PASS 后生成至少 8 个 refinement mutants；
4. 收集 reference PASS / mutant FAIL 的确定负例；
5. 若测试表明 spec 错误或过弱，则版本化修正并完整回归；
6. 冻结 spec 后用至少 4 个新 held-out mutants 测试；
7. 交付最终 spec、30 条测试、mutants、负例、幸存者和哈希 manifest。

skill 不包含模型权重。模型生成层由用户选择的本地 agent 提供；TeSpec、QCP、SMT
和 Coq 检查层在断网容器中运行。

## 维护者构建

`docker/build-image.sh` 从已存在的 QCP 8.20 基础镜像构建 TeSpec 镜像；
`docker/make-offline-bundle.sh` 将完整镜像层和离线脚本导出。目标离线机器不执行
这两个维护命令。
