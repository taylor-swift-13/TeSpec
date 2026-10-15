# array_load 模式对照

全部13个语言记录、67对输入，Fulminate67/67；OFF/ON各62 PASS、4 UNKNOWN、1 FAIL。60个read函数测试两模式全PASS；7个既有客户含2 PASS、4 UNKNOWN及1 INVALID。INVALID位于继承array_main_cast指针断言，原生成目标为False；与原CN元素值断言差异见../client-translation-oracle-review.json，冻结PASS预期保留，不先算工具误报或改预期提分。主CN全模块在main调用处报Unknown function read_proxy而被拒绝；主QCP2原始全称VC已完整编译、原始目标和数组helper假设审计、独立coqchk通过。原sizeof类型参数及既有IntArray库标准函数外延性依赖明确披露，不声称全局封闭；证书不代替其他客户测试ITP。所有实际agent/编译/审计/内核成本分别保存。
