# 前 21 组测试预期审查（2026-10-21）

已检查 21 组的 900 对输入、122 组 CN/QCP 配对和 129 个目标函数配置。分别审查 inline/modular 的 1800 项预期和 Fulminate 的 900 项预期，没有发现新增状态预期错误。沿用此前修正：translation12 客户端 inline 为 PASS、modular 为 FAIL。

[逐组审查表和明细](../benchmark/results/expectation-audit-20261021/index.md)保存每例输入、CN/QCP 源码和绑定哈希、目标函数、判定理由及独立计算见证。算术及单元内存用例由独立小解释器计算；数组、结构体和调用用例按人工审查的函数效果及规约推导。另逐例核对了 900 个 CN 包装程序中的实际参数、初始化值和别名关系与 QCP 绑定一致。脚本不读取原生执行状态或 SMT/ITP 判定，不用结果反推预期。此工作是测试预期审查，不是新增的一轮形式化证明或性能测量。

| 模式 | PASS | FAIL | 预期 ERROR |
|---|---:|---:|---:|
| inline | 498 | 379 | 23 |
| modular | 497 | 380 | 23 |

空间 SMT OFF/ON 不改变语义预期。23 个 ERROR 来自缺少读写权限或读取未初始化存储，要求匹配这种具体原因，不能把任意执行器故障算成功。错误变体在零值、相等值、无符号模回绕等输入上仍可能满足规约，不能按变体标签统一判 FAIL。

## 必须保留的比较边界

1. array_load 的 translation5、6、7、8、9、11 共 42 对测试采用比配对 CN 更强的 QCP read 后置条件。测试预期成立，但它们不能进入“相同规约 CN/QCP 对照”统计。evaluation-plan.json 和总结果索引已显式标记。3 个 verify_main 还把固定初始化数组改成入口条件，另外 4 个 main 显式写了等价数组基址转换和 return 0；这些范围转换也记录在逐配对明细。
2. read 的 7 个历史 Fulminate 预期标签 ERROR 实际表示预期运行拒绝，原始工具分类为 RUNTIME_FAILURE。本审查表统一表示为 FAIL，同时保留 fulminate_raw=ERROR；没有重写历史结果和成本。teSpec 的这 7 例继续为 ERROR。
3. 弱 read 规约可以验证 helper 自身，却不足以证明依赖返回值的客户端。translation12 的 modular 允许首个 read 返回 1，违反 zero==0；这不是实际 read 实现返回错误值。完整父目标反例的已有内核证书单独引用。
4. CN/QCP 全称验证仅适用于已选定的主程序/模块及对应源哈希。不能把主程序通过扩展成所有变体、所有历史 main 均通过。此次未更改主程序选择、证明状态或计量数据。

重放审查：`python3 tools/benchmark/audit_group_expectations.py`。源文件或输入绑定哈希变化会拒绝重放；未知语法或未覆盖的程序组不会自动视为通过。
