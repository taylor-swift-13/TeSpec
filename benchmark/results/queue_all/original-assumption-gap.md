# queue_all 原始假设缺口

原始 CN 源码声明 `assert_not_equal(pointer x, pointer y)`，前置条件为 `true`，后置条件为 `!ptr_eq(x,y)`。取两个相同指针，前置条件成立而后置条件不成立，所以这条声明不能作为任意指针上的有效定理。

这是原始输入中缺少条件的证明假设。不能据此把整个 CN 模块的接受结果称作无条件验证通过，也不能把当前测试错误归因于此假设：本次 CN 实际先在前向资源谓词 `IntQueueFB` 处解析失败；Fulminate 没有构建出测试程序。

本次 helper 的具体输入均满足非空的末节点、非空终点以及头指针不同于终点。带 guarded 规约的 QCP 变体保留这些条件。没有为迎合原始声明而更改测试预期，也没有断言所有 QCP 规约与缺少条件的 CN 声明等价。

原始源：`benchmark/programs/queue_all/variants/cn_original_queue_all/cn/queue_all.c`。完整源码哈希、逐输入绑定、两模式日志与复现命令见本组 evaluation-plan.json、20261016-evaluation/results.json 和覆盖缺口文件。
