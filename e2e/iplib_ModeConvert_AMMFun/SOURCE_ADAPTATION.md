# Source adaptation and scope

The authoritative input is:

`/home/yangfp/QCIP/INPUT/iplib/ModeConvert_AMM/source/IP_ModeConvert_AMM.c`

The original GB18030 source and all seven source-local files are preserved
byte-for-byte under `source/original/`. TeSpec now reads UTF-8 first and falls
back strictly to GB18030, so the corpus can be analyzed without replacement
characters.

`spec/final_spec.c` is a QCP-front-end copy. Its decoded
`ModeConvert_AMMFun` body is text-identical to the original. As in the bundled
StructFilter case, `float64` is represented by signed 64-bit mathematical
integers because the current QCP heap `store` layer does not materialize
arbitrary IEEE-754 heap values. The tests therefore cover the integer-valued
subset of the original double-precision state space. They are not evidence
for NaN, infinity, signed zero, rounding, or fractional behavior.

The result means only that the reference did not violate the frozen spec on
the 30 listed binds. It is not a proof of the original program for all inputs.

