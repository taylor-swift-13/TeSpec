# succ_using_incr 模式对照

全部7个现有语言记录、19对实际输入。Fulminate13 PASS、6 FAIL，19/19符合预期。teSpec OFF/ON各1 PASS、18 UNKNOWN；后者包括12正例和6预期泄漏反例，均在外部allocator缺函数体处停止，无完整执行或残余目标，不计成功。空main只有1个入口，不能重复计为多个输入。主CN缺外部释放规约被拒绝；QCP只生成13原始全称目标，证明和后续检查待完成。并行负载披露见concurrency-context.json。
