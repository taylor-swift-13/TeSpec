# abs_mem_struct 空间 SMT 对照

相同 7 个合法输入，逐次关闭／开启空间 SMT。完整分类、逐输入预期、时间和 RSS 见 results.json；模式均值见 statistics.json。两种模式均无需 ITP，模型调用及 token 为 0；ITP 均值与峰值不适用。单轮顺序运行不支持加速结论。

本组两种模式均未触发空间 SMT 查询（attempted=0）；这是开关模式的执行覆盖，不是求解器能力或性能提升的证据。执行器、运行时、32 个评测／SMT Python 模块哈希及依赖版本均可追溯；后补模块快照与本次会话开始 commit 逐文件比对一致，计量未重跑。
