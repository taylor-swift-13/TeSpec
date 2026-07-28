# IP_StructFilter QCP 验证记录

本文档记录对以下源文件的 QCP 版本进行验证的尝试过程：
`/home/yangfp/IP/ip_example/StructFilter/IP_StructFilter.c`.

状态：阻塞在 annotation 阶段。该程序尚未完成验证。

```c
#include "IP_StructFilter.h"

float64 StructFilter(float64 *X, STRUCT_FILTER *filter, float64 *PIDPara,
                     float64 Ang, float64 dAng)
{
  float64 tmpX2;
  float64 tmpX4;
  float64 tmpX6;
  float64 Kp, Ki, Kd;
  float64 Y1, Y2, Y3, Y4, U2;

  tmpX2 = X[1];
  tmpX4 = X[3];
  tmpX6 = X[5];

  Kp = PIDPara[0];
  Ki = PIDPara[1];
  Kd = PIDPara[2];

  X[0] = filter->A11 * X[0] + filter->H1 * Kp * Ang;

  Y1 = X[0] + filter->D1 * Kp * Ang;
  U2 = Y1 + Kd * dAng;
  Y2 = X[1] + filter->D2 * U2;

  X[1] = X[2] + filter->H2 * U2;
  X[2] = filter->A32 * tmpX2 + filter->A33 * X[2] + filter->H3 * U2;

  Y3 = X[3] + filter->D3 * Y2;
  X[3] = X[4] + filter->H4 * Y2;
  X[4] = filter->A54 * tmpX4 + filter->A55 * X[4] + filter->H5 * Y2;

  Y4 = X[5] + filter->D4 * Y3;

  X[5] = X[6] + filter->H6 * Y3;
  X[6] = filter->A76 * tmpX6 + filter->A77 * X[6] + filter->H7 * Y3;

  X[7] = X[7] + sTime.prd * Ki * Ang;

  return Y4;
}
```

## 文件

- QCP 源文件副本：`QCP_examples/LLM_bench/Engineering/StructFilter/IP_StructFilter.c`
- QCP 头文件副本：`QCP_examples/LLM_bench/Engineering/StructFilter/IP_StructFilter.h`
- 初始 formal lib：`SeparationLogic/examples/LLM_bench/Engineering/StructFilter/IP_StructFilter_lib.v`
- 持久化报告目录：
  `.agents/reports/QCP_examples/LLM_bench/Engineering/StructFilter/2026-07-01/IP_StructFilter-20260701T182629/`

由于 annotation gate 未通过，以下生成文件没有创建：
`IP_StructFilter_goal.v`、`IP_StructFilter_proof_auto.v`、
`IP_StructFilter_proof_manual.v` 和 `IP_StructFilter_goal_check.v`。

## 源文件适配

C 实现被复制到 QCP case 中，`StructFilter` 执行的计算逻辑没有改动。

头文件被裁剪为该函数实际用到的声明：`float64`、`GNC_TIME`、
`STRUCT_FILTER`、`sTime` 和函数原型。这样可以避免把较大的外部
`common.h` 拉入 QCP parser，同时保留目标函数相关的接口。

## 验证流程

1. intake 阶段创建了 QCP case 目录结构和本轮运行报告。
2. 在 `.tmp/float_probe` 下探测了根目录中的 `float.c` 参考程序；
   标量 `fp64` 函数可以通过 `linux-binary/symexec` 成功生成。
3. `annotation-subagent` 在 `.tmp` scratch 中执行 annotation 阶段，
   并产出了一个描述后置状态关系的候选数学规格。
4. `annotation-checking` 未通过，因为 qcp-mcp 没有检查到文件尾。

## 阻塞原因

QCP 当前会拒绝指针或结构体字段内存断言中的 `fp64` 值。典型错误为：

```text
fatal error: Cannot unify types fp64 and Z
```

这个问题既在 StructFilter 的 annotation scratch 中复现，也在最小诊断用例中复现：

- `double *p` 配合 `x == *p`
- `double *p` 配合 `store(p, x)`
- `double *p` 配合 `store(p, double, x)`
- `struct S { double a; }` 配合 `x == s->a`

`StructFilter` 必然会读写 `float64 *X`，读取 `float64 *PIDPara`，读取
`STRUCT_FILTER` 中的 double 字段，并读取 `sTime.prd`。这些对象都是 fp64
内存单元，因此在这个前端支持问题解决之前，或者在明确接受另一种建模方式之前，
direct QCP proof 无法继续推进。

## 候选规格

被阻塞的 annotation 轮次产出了
`20260701T183054-annotation-r1/candidate_patch.diff`。
该 patch 使用公式化关系描述返回值以及更新后的 `X[0..7]`，这些关系由旧状态、
filter 系数、PID 参数、`Ang`、`dAng` 和 `sTime.prd` 决定。

由于 `qcp_mcp_requirement_satisfied: no`，该 patch 没有集成到正式 formal 源文件中。

## 后续步骤

如果要把这个 case 作为 direct proof 继续推进，需要找到 QCP 支持的 fp64
指针/字段资源 annotation 写法，或者修复前端对这类资源的支持。按值传递版本或
整数建模版本会成为另一个验证目标，不能视为当前原始 double 指针程序的完整证明。
