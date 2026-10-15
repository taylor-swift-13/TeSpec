# teSpec 单分支、单工作树

唯一分支为 `main`，唯一工作树为 `/home/yangfp/teSpec`（由 `/home/yangfp/teSpec-benchmark-tespec` 重命名）。工具代码、运行时和当前 benchmark 均以这个工作树为准。原旧工作树中的未提交工具修改不覆盖当前代码，完整旧目录另作仓库外备份；论文的新增案例章节及所需历史证据整理进 `paper/`，过时实例状态文档移至 `arxiv/paper-superseded-instance-state/`。

历史论文数据保持原有日期、哈希和测量范围，不混入当前 read 评测。`paper/evidence/comparative-case-studies-20261013/archive-index.json` 记录论文证据迁移。

清理过程先验证旧目录完整归档及 Git bundle，再把保留工作树转为独立仓库，最后移除两个旧工作树目录。sac 仓库不作修改、不 push。当前 benchmark、执行器二进制和模型计量证据均保持不变。

后续只在此目录的 `main` 上线性开发，不新建分支或工作树，除非用户明确更改要求。`git pull` 配置为 `--ff-only`。历史评测文件保留原始绝对路径与哈希，审计通过 `tools/benchmark/evidence_paths.py` 将旧工作树前缀解析到当前仓库；不为旧路径保留额外工作树或符号链接。
