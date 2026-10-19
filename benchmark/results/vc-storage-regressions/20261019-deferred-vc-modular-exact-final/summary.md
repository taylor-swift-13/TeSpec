# Inline VC storage differential regression

Original Coq goal/auto/check bytes, raw native decisions, witness counts and enabled instance traces are compared.
Only generated output directory prefixes, explicitly named additive metrics, and validated branch query counters are normalized.
Runs execute serially. Times/RSS are observations; a single pair does not establish a general speedup.
No ITP or Coq certificate is inferred. Native model tokens: 0.

| Case | Exact gate | Old/new VC count | Old/new executor seconds | Old/new peak KiB |
| --- | --- | --- | --- | --- |
| abs/cn_original:abs/value_0/off | PASS | 4 / 4 | 0.004636 / 0.006456 | 5300 / 5304 |
| abs/cn_original:abs/value_0/on | PASS | 4 / 4 | 0.004494 / 0.005881 | 5188 / 5260 |
| abs_mem/cn_original:abs_mem/value_0/off | PASS | 4 / 4 | 0.005425 / 0.007159 | 5068 / 5200 |
| abs_mem/cn_original:abs_mem/value_0/on | PASS | 4 / 4 | 0.00475 / 0.006379 | 5292 / 5292 |
| abs_mem_struct/cn_original:abs_mem_struct/value_0/off | PASS | 2 / 2 | 0.007698 / 0.008374 | 5548 / 5304 |
| abs_mem_struct/cn_original:abs_mem_struct/value_0/on | PASS | 2 / 2 | 0.006439 / 0.007015 | 5452 / 5324 |
| add/cn_original:add_2/pair_0/off | PASS | 2 / 2 | 0.005535 / 0.006241 | 4932 / 4836 |
| add/cn_original:add_2/pair_0/on | PASS | 2 / 2 | 0.004517 / 0.006306 | 4788 / 5012 |
| add_read/cn_original:add_read/pair_0/off | PASS | 1 / 1 | 0.005157 / 0.005698 | 4908 / 4912 |
| add_read/cn_original:add_read/pair_0/on | PASS | 1 / 1 | 0.004818 / 0.005931 | 4864 / 5052 |
| add_two_array/cn_original:add_two_array/array_0/off | PASS | 1 / 1 | 0.007479 / 0.009727 | 5696 / 5692 |
| add_two_array/cn_original:add_two_array/array_0/on | PASS | 1 / 1 | 0.00745 / 0.009195 | 5752 / 5816 |
| array_load/cn_original:array_load.broken/read_translation3_0/off | PASS | 1 / 1 | 0.007503 / 0.009503 | 5836 / 5932 |
| array_load/cn_original:array_load.broken/read_translation3_0/on | PASS | 1 / 1 | 0.008454 / 0.009302 | 6008 / 5816 |
| const_example/cn_original:const_example/x_0/off | PASS | 2 / 2 | 0.004294 / 0.005325 | 4760 / 4804 |
| const_example/cn_original:const_example/x_0/on | PASS | 2 / 2 | 0.004173 / 0.005505 | 4776 / 4932 |
| example_let/cn_original:slf1_basic_example_let/n_0/off | PASS | 3 / 3 | 0.004886 / 0.007549 | 5260 / 5044 |
| example_let/cn_original:slf1_basic_example_let/n_0/on | PASS | 3 / 3 | 0.005117 / 0.006195 | 5292 / 5028 |
| incr/cn_original:slf0_basic_incr/input_0/off | PASS | 2 / 2 | 0.005302 / 0.006248 | 5068 / 4772 |
| incr/cn_original:slf0_basic_incr/input_0/on | PASS | 2 / 2 | 0.004533 / 0.006548 | 5168 / 4912 |
| incr_first/cn_original:slf7_basic_incr_first/pair_0/off | PASS | 2 / 2 | 0.007042 / 0.009026 | 5444 / 5316 |
| incr_first/cn_original:slf7_basic_incr_first/pair_0/on | PASS | 2 / 2 | 0.00696 / 0.008339 | 5488 / 5284 |
| init_point/cn_original:init_point/region_0/off | PASS | 1 / 1 | 0.005593 / 0.007968 | 5300 / 5364 |
| init_point/cn_original:init_point/region_0/on | PASS | 1 / 1 | 0.005755 / 0.00721 | 5564 / 5484 |
| quadruple/cn_original:slf2_basic_quadruple/n_0/off | PASS | 1 / 1 | 0.005299 / 0.005502 | 5024 / 5004 |
| quadruple/cn_original:slf2_basic_quadruple/n_0/on | PASS | 1 / 1 | 0.004502 / 0.006518 | 4744 / 4748 |
| read/cn_original:read2/value_0/off | PASS | 1 / 1 | 0.005203 / 0.005562 | 5036 / 4756 |
| read/cn_original:read2/value_0/on | PASS | 1 / 1 | 0.004799 / 0.005713 | 4792 / 4908 |
| slf3_basic_inplace_double/cn_original:slf3_basic_inplace_double/value_0/off | PASS | 2 / 2 | 0.005193 / 0.005112 | 5040 / 5176 |
| slf3_basic_inplace_double/cn_original:slf3_basic_inplace_double/value_0/on | PASS | 2 / 2 | 0.005121 / 0.005118 | 5260 / 5064 |
| slf_quadruple_mem/cn_original:slf_quadruple_mem/value_0/off | PASS | 3 / 3 | 0.005244 / 0.00626 | 5164 / 5288 |
| slf_quadruple_mem/cn_original:slf_quadruple_mem/value_0/on | PASS | 3 / 3 | 0.005269 / 0.005862 | 5180 / 5164 |
| swap/cn_original:swap/pair_0/off | PASS | 1 / 1 | 0.005251 / 0.006286 | 5028 / 4784 |
| swap/cn_original:swap/pair_0/on | PASS | 1 / 1 | 0.005473 / 0.005815 | 5032 / 5004 |
| swap_array/cn_original:swap_array/array_0/off | PASS | 1 / 1 | 0.009113 / 0.010686 | 6028 / 6004 |
| swap_array/cn_original:swap_array/array_0/on | PASS | 1 / 1 | 0.009526 / 0.011502 | 6004 / 5864 |
| transfer/cn_original:slf8_basic_transfer/pair_0/off | PASS | 2 / 2 | 0.005271 / 0.006238 | 5156 / 5056 |
| transfer/cn_original:slf8_basic_transfer/pair_0/on | PASS | 2 / 2 | 0.005253 / 0.006101 | 5276 / 5248 |
| transpose/cn_original:transpose/point_0/off | PASS | 1 / 1 | 0.004543 / 0.005971 | 5176 / 5028 |
| transpose/cn_original:transpose/point_0/on | PASS | 1 / 1 | 0.00454 / 0.006225 | 5172 / 5184 |
| zero/cn_original:zero/region_0/off | PASS | 2 / 2 | 0.004733 / 0.004659 | 4932 / 4780 |
| zero/cn_original:zero/region_0/on | PASS | 2 / 2 | 0.005398 / 0.004716 | 4776 / 4812 |
