# TeSpec E2E artifacts

每个直接端到端任务使用独立的 `e2e/<case-id>/` 目录，并由
`skills/tespec-artifacts/scripts/manage_artifacts.py` 生成和校验
`artifact-manifest.json`。

任务目录中的 spec、binds、mutants 和最终 JSON 判定摘要属于持久产物；
逐次运行产生的 `.v` 证明源、日志、`.vo/.glob/.aux`、Python bytecode 和 solver
cache 都是可再生产物，不进入交付包。
