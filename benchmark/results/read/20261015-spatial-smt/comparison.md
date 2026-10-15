# read：spatial SMT 模式对照

相同的 61 对输入分别运行显式关闭与开启模式，共 122 次新执行。OFF 复现历史分类；ON 将 12 个 UNKNOWN 全部变为 FAIL，其他 49 条分类不变。最终两种完整流程均为 22 PASS、32 FAIL、7 个预期 ERROR，61/61 符合预期；OFF 的 12 次 ITP 使用目标哈希匹配的已有逐次证据，ON 无需额外 ITP 判定测试结果。

| 项目 | OFF | ON |
|---|---:|---:|
| 原生结果 PASS / FAIL / UNKNOWN / ERROR | 22 / 20 / 12 / 7 | 22 / 32 / 0 / 7 |
| 执行阶段每次平均时间（秒） | 0.172222 | 0.170630 |
| 执行阶段平均单次峰值 RSS（MiB） | 19.5223 | 26.5344 |
| 执行阶段最大峰值 RSS（MiB） | 19.7188 | 55.2344 |
| 需 ITP 判定的测试执行数 | 12 | 0 |
| 所需 ITP 的平均时间（秒） | 201.2033（复用实测） | —（无需） |
| 本次新消耗 token | 0 | 0 |

OFF 的完整成本仍包括复用的 ITP token，不能将“本次未调用模型”写成历史 ITP 免费。原始分阶段成本见已有 tespec 统计及本目录 statistics.json。ON 的判定只使用 SMT，新增 ITP 时间与 token 均为 0。

12 条查询均保存 SMT-LIB 和 SAT 反例堆，已重放确认 SAT，并逐条核对四字节整数反例及原始 VC 哈希；结论与已有 Coq 内核反证一致。SMT 结果的 certificate 保持 NOT_CHECKED，不冒充新生成的 Coq 证书。查询预算每条 2000 ms；Z3 4.13.3。

20 条本来已 FAIL 的数值错误用例仍保留 residual ITP 清单，属于原始义务记录；已有决定性 INVALID 足以判 FAIL，不需要为判定测试结果继续证明其余义务。ON 消解的 12 条 UNKNOWN 其待处理 ITP 组均为空。

本次测试使用当前工作区的 spatial-smt 功能，相关实现尚未提交；results.json 保存精确模块哈希和起始 Git revision，不把它伪称为仅由该 revision 即可复现的功能。两次模式调用的顺序固定为 OFF 后 ON，仅一轮测量，细小时间差不用于宣称执行阶段加速。

原始结果见 [results.json](results.json)，指标见 [statistics.json](statistics.json)，逐例对照见 [cases.csv](cases.csv)。
