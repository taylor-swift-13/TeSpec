# 执行状态保持与分类测试验收

当前语义为 `inline-preserve/v1`。两个模式都实际执行循环及可用函数体；`all-boundaries` 开启中间 assert/inv/Require/Ensure 检查，`entry-exit` 默认忽略这些检查。检查目标取当前状态副本，执行状态保持原样。实现复用 QCP 的实参求值、内存操作、分离匹配和 VC 生成，通过新鲜调用帧支持递归、共享指针、结构体参数及返回。

实现代码位于 sac 的 `tespec` 工作树 `/tmp/sac-tespec-merge-J7CxUo`，teSpec 的 `tespec` 工作树为 `/tmp/teSpec-tespec-agentflow`。候选执行器是 `bin/tespec-symexec`，构建身份在 `bin/tespec-symexec.build.json`；原 `bin/qcp-symexec` 保持不变。源示例目录只读。

## 本次有预期的测试

| 测试层 | 结果 |
|---|---|
| 分类端到端矩阵 | 1,322/1,322 符合预期，89 个功能程序/专项场景、18 类 |
| 同一矩阵 ASan/UBSan | 1,322/1,322，无检测器报错；关闭泄漏检查 |
| 原生 C 与 Python oracle | 52 个程序 × 4 个输入一致；52 个程序变异均有可区分输入 |
| sac 调用/边界/状态回归 | 37 个测试通过（含继承的 19 个状态保持测试） |
| sac 规约执行回归 | 42 个测试通过 |
| Require/VC 产物回归 | 43 个测试通过 |
| 内存可满足性矩阵 | 281/281：142 SAT、135 UNSAT、4 UNKNOWN |
| QCP 原例定向输入 | 40/40：27 PASS、10 INVALID、3 UNKNOWN |
| teSpec Python 测试 | 106 个测试通过，无跳过 |

分类矩阵包含 779 次负例检查，误报 PASS 为 0。541 PASS、757 UNKNOWN、14 ERROR、10 INVALID 是执行器状态分布；故意错误的 Ensure 和安全性义务应保留 VC 并返回 UNKNOWN，因此“符合预期”不等于“执行器 PASS”。本次没有运行 ITP Agent 或重放证明证书。

测试说明及命令见 [分类测试](../../benchmark/executor_e2e/README.md)，紧凑报告见 [executor-e2e-results.json](../../paper/executor-e2e-results.json)。完整运行产物在 `/tmp/tespec-evaluation/typed-e2e-publish`，检测器版本在 `typed-e2e-sanitized`。时间、CPU、峰值 RSS 按输入保留；这些是回归运行观测值，未做隔离性能实验。

## 测试发现并修复的问题

1. **谓词展开丢失返回值约束。** 旧实现消去 Ensure 的存在返回变量，却保留外部引用的旧返回项。8 个错误后条件因此被判为 PASS。展开器现在保护进入展开前已有的存在变量，只消去本次展开新引入的局部见证。正反例覆盖直接/存在/析取返回条件、守卫及嵌套定义。
2. **类型化指针偏移未进入可满足性 SMT 查询。** `IntArray::full(p,2,[1,2]) * data_at(p+1,int,2)` 曾留下 UNKNOWN。新增对 `base + index * sizeof(element)` 的闭合偏移编码，支持符号基址；冲突现在为 UNSAT。负偏移、重叠及相邻单元配对测试排除按固定地址或单个例子处理。
3. **完成执行与证明 Ensure 的状态混淆。** 控制器此前把错误 Ensure 的已完成执行也显示为 UNKNOWN，现在从执行器 `completed` 字段报告执行完成，后条件仍独立保留 UNKNOWN。
4. **调用匹配失败的注解阶段误标 PASS。** `contract_binding_unknown` 现在使 annotations=UNKNOWN。当前这类失败仍可能缺少可交给 ITP 的调用入口 VC，报告保留该障碍。
5. **既有类型推断测试依赖可变的外部 OUTPUT。** 改为临时目录内固定的头文件与 C 源码，继续检查 include 中的任意 Coq 类型推断，消除与外部证明会话的耦合。

返回项与断言的联合语义、调用及循环算法见 [形式化](../../paper/instance-semantics.md) 和 [PDF](../../paper/instance-semantics.pdf)。

## 覆盖边界

内存矩阵的四个 UNKNOWN 是超出声明子对象的存储、结构体数组字段越界、opaque 及其析取。QCP 定向输入的三个 UNKNOWN 是非空 `array_copy1` 在访问不变式时留下的空间 VC。分类矩阵的链表、树和 DAG 是有限符号地址形状；任意抽象递归谓词、实际动态分配、部分 C 构造仍存在覆盖障碍。

Require 的 UNSAT 与安全性 UNKNOWN 分开统计；缺少函数体、执行预算耗尽或匹配不完整都不能升级为 PASS。执行中的外部声明不能用 Ensure 代替函数体。声明本身可作为 specification-only 目标检查 Require。

QCP 全库合成输入扫描单列在当前 [总报告](../../paper/instance-semantics-evaluation.json)，其 INVALID 可能来自合成绑定本身，UNKNOWN/ERROR/NEEDS_BINDINGS 显示支持范围，不充当正确性 oracle。

## 当前 QCP 全库扫描

扫描 267 个 C 文件、1,147 个规约。对可自动生成绑定的目标运行 5,160 次：1,086 PASS、1,022 INVALID、2,416 UNKNOWN、636 ERROR。另有 287 个规约需要显式类型或逻辑绑定，记为 NEEDS_BINDINGS，不计入已运行次数。完整结果与原因分类见 [扫描摘要](inline-preserve-corpus-results.json)。

## 无执行器源码的运行验证

使用 bubblewrap 隐藏外部 QCP/sac checkout，仅挂载系统依赖、teSpec 仓库及输出目录。完整 1,322 次分类测试全部符合预期，二进制与发布候选哈希一致。运行依赖 `bin/tespec-symexec` 和 `runtime/qcip`；重新构建二进制才需要外部源码。此次没有运行 ITP。
