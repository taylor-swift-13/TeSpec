# TeSpec E2E artifacts

每个直接端到端任务使用独立的 `e2e/<case-id>/` 目录，并由
`skills/tespec-artifacts/scripts/manage_artifacts.py` 生成和校验
`artifact-manifest.json`。`catalog/` 只保存语料摄取索引，不混入任务证据。

任务目录中的 spec、binds、mutants、`.v` 证明源、日志和 JSON 报告属于持久产物；
`.vo/.glob/.aux`、Python bytecode 和 solver cache 属于可再生缓存，不进入交付包。
