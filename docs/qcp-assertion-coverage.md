# QCP assertion coverage

本清单对应 TeSpec 随附 QCP parser 的 assertion grammar。`qcp-spectest`
只向选中 spec 的 `Require` 插入绑定等式，其余 assertion 文本不做降级转换，
所以以下格式都可继续交给 QCP。

## Function spec 外壳

- `Require P Ensure Q`
- `With {A ...} (x ... : T) Require P Ensure Q`
- 只有 type-level 或只有 value-level `With`
- `Declare (a: (ctype)[length]) ...`
- 命名 spec：`name ...`
- derived spec：`name <= base ...`
- 同一函数连续多个 full spec
- 定义处只引用名字的 spec（由 QCP 自身解析）

## 类型

- type variable、type constructor application
- 乘积类型
- 箭头/高阶逻辑函数类型
- `{A}` 与 `{A :: kind}` 多态参数
- typed/untyped value binders

## Assertion 原子和表达式

- 逻辑变量、`#shadow`、整数、浮点、字符串、括号和类型标注
- `__return`、`__time_cost`、`sizeof(type)`、`emp`
- 函数/谓词应用、数组下标
- 字段和指针字段、带显式 C 类型的字段形式
- `x@pre` 等 old-state 表达式
- 取地址、解引用、cast、正负号、逻辑非、按位非
- `* / % + - << >>`
- `< > <= >= == !=`
- `& ^ | && ||`
- implication `=>` 与 iff `<=>`
- assertion 中嵌入函数 spec 的表达式形式

## Heap 原子

- `data_at(addr, value)`
- `data_at(addr, type, value)`
- `store_char`、`store_uchar`、`store_short`、`store_ushort`
- `store_int`、`store_uint`、`store_int64`、`store_uint64`
- `store_ptr`，包括显式 pointee type 形式
- 对应的 `undef_data_at` / `undef_store_*`
- `field_addr`
- `pointer_offset`
- `arr`，包括显式 element type 形式
- 用户定义或 `Extern Coq` separation predicates，例如 `sll`

## 量词

- `forall x, P`、`exists x, P`
- 多个无类型 binder
- `(x y: T)` typed binder
- `({A} -> T)` 高阶 binder
- bracket existential：`[x]`、`[x y: T]`

## Binds 的边界

每条用例的 `args` 必须覆盖目标函数全部 C 形参；指针以具体数值地址输入。
Python 端的 `values` 可编码整数、布尔、typed list 和任意递归 constructor tree。任意其他
Coq/QCP 类型使用 `{"type": "T", "qcp": "term"}`，因此不存在仅因 Python
不知道类型而无法绑定的 `With`。type-level `With {A}` 可在 case 的 `types`
对象中实例化，工具会删除对应 type binder 并在选中 spec 内做 identifier-level
类型名替换。

`analyze` 会递归读取 quoted includes，从 `Extern Coq` 函数/谓词签名反推无类型
`With`；无法唯一推出时明确标记 `type_source: unknown`，由用户或 skill 的模型层
给出显式 `type + qcp`。

自定义 separation predicate 不按名字识别。`Let` 定义由 concrete executor 直接
实例化；`Extern Coq` 谓词需要源码声明的 strategies。仅有声明而无定义/规则时，
执行器没有可靠语义可用于物化 heap。

“能解析”不等于“必然自动证明”。自动证明还取决于具体 bind 是否让路径有限、
外部谓词是否有可执行展开规则/公理，以及 SMT 后端是否覆盖所需理论。
