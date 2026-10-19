# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes and explicitly named additive storage metrics are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| abs/cn_original:abs/value_0/off | PASS | 4 / 4 | 0.005254 / 0.004636 | 5304 / 5300 |
| abs/cn_original:abs/value_0/on | PASS | 4 / 4 | 0.004432 / 0.004494 | 5160 / 5188 |
| abs_mem/cn_original:abs_mem/value_0/off | PASS | 4 / 4 | 0.005617 / 0.005425 | 5164 / 5068 |
| abs_mem/cn_original:abs_mem/value_0/on | PASS | 4 / 4 | 0.004896 / 0.00475 | 5016 / 5292 |
| abs_mem_struct/cn_original:abs_mem_struct/value_0/off | PASS | 2 / 2 | 0.006868 / 0.007698 | 5388 / 5548 |
| abs_mem_struct/cn_original:abs_mem_struct/value_0/on | PASS | 2 / 2 | 0.006233 / 0.006439 | 5452 / 5452 |
| add/cn_original:add_2/pair_0/off | PASS | 2 / 2 | 0.00457 / 0.005535 | 4876 / 4932 |
| add/cn_original:add_2/pair_0/on | PASS | 2 / 2 | 0.005212 / 0.004517 | 4784 / 4788 |
| add_read/cn_original:add_read/pair_0/off | PASS | 1 / 1 | 0.004917 / 0.005157 | 5004 / 4908 |
| add_read/cn_original:add_read/pair_0/on | PASS | 1 / 1 | 0.004939 / 0.004818 | 5180 / 4864 |
| add_two_array/cn_original:add_two_array/array_0/off | PASS | 1 / 1 | 0.010038 / 0.007479 | 5772 / 5696 |
| add_two_array/cn_original:add_two_array/array_0/on | PASS | 1 / 1 | 0.008099 / 0.00745 | 5756 / 5752 |
| array_load/cn_original:array_load.broken/read_translation3_0/off | PASS | 1 / 1 | 0.007884 / 0.007503 | 5832 / 5836 |
| array_load/cn_original:array_load.broken/read_translation3_0/on | PASS | 1 / 1 | 0.007397 / 0.008454 | 5808 / 6008 |
| const_example/cn_original:const_example/x_0/off | PASS | 2 / 2 | 0.004707 / 0.004294 | 4792 / 4760 |
| const_example/cn_original:const_example/x_0/on | PASS | 2 / 2 | 0.00562 / 0.004173 | 4788 / 4776 |
| example_let/cn_original:slf1_basic_example_let/n_0/off | PASS | 3 / 3 | 0.005327 / 0.004886 | 5248 / 5260 |
| example_let/cn_original:slf1_basic_example_let/n_0/on | PASS | 3 / 3 | 0.0049 / 0.005117 | 5292 / 5292 |
| incr/cn_original:slf0_basic_incr/input_0/off | PASS | 2 / 2 | 0.004687 / 0.005302 | 5184 / 5068 |
| incr/cn_original:slf0_basic_incr/input_0/on | PASS | 2 / 2 | 0.004776 / 0.004533 | 5020 / 5168 |
| incr_first/cn_original:slf7_basic_incr_first/pair_0/off | PASS | 2 / 2 | 0.006899 / 0.007042 | 5480 / 5444 |
| incr_first/cn_original:slf7_basic_incr_first/pair_0/on | PASS | 2 / 2 | 0.008074 / 0.00696 | 5424 / 5488 |
| init_point/cn_original:init_point/region_0/off | PASS | 1 / 1 | 0.005857 / 0.005593 | 5432 / 5300 |
| init_point/cn_original:init_point/region_0/on | PASS | 1 / 1 | 0.005728 / 0.005755 | 5452 / 5564 |
| quadruple/cn_original:slf2_basic_quadruple/n_0/off | PASS | 1 / 1 | 0.005574 / 0.005299 | 4892 / 5024 |
| quadruple/cn_original:slf2_basic_quadruple/n_0/on | PASS | 1 / 1 | 0.005108 / 0.004502 | 4772 / 4744 |
| read/cn_original:read2/value_0/off | PASS | 1 / 1 | 0.00452 / 0.005203 | 4780 / 5036 |
| read/cn_original:read2/value_0/on | PASS | 1 / 1 | 0.004661 / 0.004799 | 4752 / 4792 |
| slf3_basic_inplace_double/cn_original:slf3_basic_inplace_double/value_0/off | PASS | 2 / 2 | 0.005685 / 0.005193 | 5248 / 5040 |
| slf3_basic_inplace_double/cn_original:slf3_basic_inplace_double/value_0/on | PASS | 2 / 2 | 0.005407 / 0.005121 | 5176 / 5260 |
| slf_quadruple_mem/cn_original:slf_quadruple_mem/value_0/off | PASS | 3 / 3 | 0.005257 / 0.005244 | 5292 / 5164 |
| slf_quadruple_mem/cn_original:slf_quadruple_mem/value_0/on | PASS | 3 / 3 | 0.004535 / 0.005269 | 5152 / 5180 |
| swap/cn_original:swap/pair_0/off | PASS | 1 / 1 | 0.00464 / 0.005251 | 5004 / 5028 |
| swap/cn_original:swap/pair_0/on | PASS | 1 / 1 | 0.005105 / 0.005473 | 4844 / 5032 |
| swap_array/cn_original:swap_array/array_0/off | PASS | 1 / 1 | 0.009946 / 0.009113 | 6076 / 6028 |
| swap_array/cn_original:swap_array/array_0/on | PASS | 1 / 1 | 0.008931 / 0.009526 | 6012 / 6004 |
| transfer/cn_original:slf8_basic_transfer/pair_0/off | PASS | 2 / 2 | 0.004974 / 0.005271 | 5100 / 5156 |
| transfer/cn_original:slf8_basic_transfer/pair_0/on | PASS | 2 / 2 | 0.006273 / 0.005253 | 5040 / 5276 |
| transpose/cn_original:transpose/point_0/off | PASS | 1 / 1 | 0.005095 / 0.004543 | 5232 / 5176 |
| transpose/cn_original:transpose/point_0/on | PASS | 1 / 1 | 0.005263 / 0.00454 | 5048 / 5172 |
| zero/cn_original:zero/region_0/off | PASS | 2 / 2 | 0.004828 / 0.004733 | 4932 / 4932 |
| zero/cn_original:zero/region_0/on | PASS | 2 / 2 | 0.004388 / 0.005398 | 4936 / 4776 |
