# Four-class benchmark program shortlist

> Status: static shortlist. A program enters the released benchmark only
> after its reference semantics, candidate labels, and witnesses have
> passed the semantic audit described in `../DESIGN.zh-CN.md`.

## Summary

- Target functions: 100
- Source families: 86
- Multi-call targets: 54
- Native `float`/`double` targets: 10
- Float-model targets: 11
- Heap targets: 94
- Singly linked targets: 14
- Doubly linked targets: 8
- Quantified specifications: 76

## Programs

| # | Corpus | Family | Target | Score | Main features | Source |
|---:|---|---|---|---:|---|---|
| 1 | cav | add_binary_strings | `add_binary_strings` | 52.56 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/add_binary_strings.c` |
| 2 | cav | array_is_sorted_csv | `array_is_sorted_csv` | 43.43 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/array_is_sorted_csv.c` |
| 3 | cav | array_min_csv | `array_min_csv` | 45.84 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/array_min_csv.c` |
| 4 | cav | aug_all_multiple_array_003 | `aug_all_multiple_array_003` | 37.72 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/aug_all_multiple_array_003.c` |
| 5 | cav | contains_duplicate_csv | `contains_duplicate_csv` | 43.37 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/contains_duplicate_csv.c` |
| 6 | cav | count_good_pairs_csv | `count_good_pairs_csv` | 43.49 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/count_good_pairs_csv.c` |
| 7 | cav | decode_xored_array_csv | `decode_xored_array_csv` | 52.80 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/decode_xored_array_csv.c` |
| 8 | cav | ex_anagram_count | `ex_anagram_count` | 75.41 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/ex_anagram_count.c` |
| 9 | cav | ex_binary_search_index_csv | `ex_binary_search_index_csv` | 44.55 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/ex_binary_search_index_csv.c` |
| 10 | cav | p006_parse_nested_parens | `p006_parse_nested_parens` | 48.40 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p006_parse_nested_parens.c` |
| 11 | cav | p010_make_palindrome | `p010_make_palindrome` | 41.95 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p010_make_palindrome.c` |
| 12 | cav | p017_parse_music | `p017_parse_music` | 61.91 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p017_parse_music.c` |
| 13 | cav | p026_remove_duplicates | `p026_remove_duplicates` | 48.51 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p026_remove_duplicates.c` |
| 14 | cav | p033_sort_third | `p033_sort_third` | 41.67 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p033_sort_third.c` |
| 15 | cav | p058_common | `p058_common` | 40.82 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p058_common.c` |
| 16 | cav | p065_circular_shift | `p065_circular_shift` | 46.47 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p065_circular_shift.c` |
| 17 | cav | p067_fruit_distribution | `p067_fruit_distribution` | 37.42 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p067_fruit_distribution.c` |
| 18 | cav | p069_search | `p069_search` | 36.85 | calls, heap, nested-control, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p069_search.c` |
| 19 | cav | p070_strange_sort_list | `p070_strange_sort_list` | 41.59 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p070_strange_sort_list.c` |
| 20 | cav | p079_decimal_to_binary | `p079_decimal_to_binary` | 39.17 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p079_decimal_to_binary.c` |
| 21 | cav | p084_solve | `p084_solve` | 40.30 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p084_solve.c` |
| 22 | cav | p088_sort_array | `p088_sort_array` | 42.48 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p088_sort_array.c` |
| 23 | cav | p096_count_up_to | `p096_count_up_to` | 41.80 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p096_count_up_to.c` |
| 24 | cav | p107_even_odd_palindrome | `p107_even_odd_palindrome` | 36.76 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p107_even_odd_palindrome.c` |
| 25 | cav | p116_sort_array | `p116_sort_array` | 67.69 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p116_sort_array.c` |
| 26 | cav | p118_get_closest_vowel | `p118_get_closest_vowel` | 40.68 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p118_get_closest_vowel.c` |
| 27 | cav | p119_match_parens | `p119_match_parens` | 58.39 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p119_match_parens.c` |
| 28 | cav | p120_maximum | `p120_maximum` | 43.71 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p120_maximum.c` |
| 29 | cav | p124_valid_date | `p124_valid_date` | 37.96 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p124_valid_date.c` |
| 30 | cav | p136_largest_smallest_integers | `p136_largest_smallest_integers` | 36.52 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p136_largest_smallest_integers.c` |
| 31 | cav | p140_fix_spaces | `p140_fix_spaces` | 42.63 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p140_fix_spaces.c` |
| 32 | cav | p141_file_name_check | `p141_file_name_check` | 59.49 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p141_file_name_check.c` |
| 33 | cav | p143_words_in_sentence | `p143_words_in_sentence` | 46.31 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p143_words_in_sentence.c` |
| 34 | cav | p144_simplify | `p144_simplify` | 38.01 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p144_simplify.c` |
| 35 | cav | p145_order_by_points | `p145_order_by_points` | 53.14 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p145_order_by_points.c` |
| 36 | cav | p152_compare | `p152_compare` | 39.18 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p152_compare.c` |
| 37 | cav | p155_even_odd_count | `p155_even_odd_count` | 37.40 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p155_even_odd_count.c` |
| 38 | cav | p161_solve | `p161_solve` | 40.04 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p161_solve.c` |
| 39 | cav | p163_generate_integers | `p163_generate_integers` | 36.95 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p163_generate_integers.c` |
| 40 | cav_os_float | xizi | `float64_mul_add` | 12.00 | float, heap, Coq | `/home/yangfp/CAV/OS/CAV-bench/input/xizi/float64_no_loop.c` |
| 41 | qcip_output | IP/StructFilter | `StructFilter` | 43.72 | heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/IP/StructFilter/source/IP_StructFilter.c` |
| 42 | qcip_output | IP/WheelFriction | `WheelFriction` | 46.92 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/IP/WheelFriction/source/IP_WheelFriction.c` |
| 43 | qcip_output | SAMCodeSynthesis/B_TcProcess | `B_TcProcessFun` | 51.94 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/B_TcProcess/source/IP_B_TcProcess.c` |
| 44 | qcip_output | SAMCodeSynthesis/JetCtrlSend | `JetCtrlSendFun` | 40.56 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/JetCtrlSend/source/IP_JetCtrlSend.c` |
| 45 | qcip_output | SAMCodeSynthesis/ThrusterCtrlLogic | `ThrusterCtrlLogicFun` | 47.62 | heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/ThrusterCtrlLogic/source/IP_ThrusterCtrlLogic.c` |
| 46 | qcip_output | float/float_clamp | `double_clamp` | 10.58 | float, Coq | `/home/yangfp/QCIP/OUTPUT/float/float_clamp/source/float_clamp.c` |
| 47 | qcip_output | float/float_clamp | `float_clamp` | 14.58 | float, heap, Coq | `/home/yangfp/QCIP/OUTPUT/float/float_clamp/source/float_clamp.c` |
| 48 | qcip_output | float/float_store | `write_float_direct` | 11.36 | float, heap, Coq | `/home/yangfp/QCIP/OUTPUT/float/float_store/source/store_float_direct.c` |
| 49 | qcip_output | float/float_store | `write_struct_float` | 15.06 | float, heap, struct, Coq | `/home/yangfp/QCIP/OUTPUT/float/float_store/source/store_float_struct.c` |
| 50 | qcip_output | xizi/xizi_double_link_insert_after | `xizi_double_link_insert_after` | 26.56 | heap, dll, struct, Coq | `/home/yangfp/QCIP/OUTPUT/xizi/xizi_double_link_insert_after/source/xizi_double_link_insert_after.c` |
| 51 | qcip_output | xizi/xizi_double_link_insert_before | `xizi_double_link_insert_before` | 23.36 | heap, dll, struct | `/home/yangfp/QCIP/OUTPUT/xizi/xizi_double_link_insert_before/source/xizi_double_link_insert_before.c` |
| 52 | qcip_output | xizi/xizi_double_link_len | `xizi_double_link_len` | 25.68 | heap, dll, struct, Coq | `/home/yangfp/QCIP/OUTPUT/xizi/xizi_double_link_len/source/xizi_double_link_len.c` |
| 53 | qcip_output | xizi/xizi_double_link_remove_node | `xizi_double_link_remove_node` | 24.80 | heap, dll, struct, Coq | `/home/yangfp/QCIP/OUTPUT/xizi/xizi_double_link_remove_node/source/xizi_double_link_remove_node.c` |
| 54 | qcp | Applications_human/convex_hull/andrew_monotone_chain | `andrew_build_from_sorted` | 64.62 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/andrew_monotone_chain.c` |
| 55 | qcp | Applications_human/convex_hull/andrew_monotone_chain | `partition_xy_points` | 45.19 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/andrew_monotone_chain.c` |
| 56 | qcp | Applications_human/convex_hull/graham_scan | `build_hull_from_sorted_tail` | 55.45 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/graham_scan.c` |
| 57 | qcp | Applications_human/convex_hull/graham_scan | `graham_scan` | 57.22 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/graham_scan.c` |
| 58 | qcp | Applications_human/convex_hull/graham_scan_dedup | `build_hull_from_sorted_tail_dedup` | 56.17 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/graham_scan_dedup.c` |
| 59 | qcp | Applications_human/convex_hull/graham_scan_dedup | `dedup_points_and_find_leftmost` | 59.56 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/Applications_human/convex_hull/graham_scan_dedup.c` |
| 60 | qcp | Applications_human/fme/fme | `generate_new_constr` | 50.35 | calls, heap, struct, nested-control, quantifiers | `/home/yangfp/QCIP/QCP_examples/Applications_human/fme/fme.c` |
| 61 | qcp | Applications_human/fme/fme | `real_shadow` | 47.05 | calls, heap, struct, nested-control, quantifiers | `/home/yangfp/QCIP/QCP_examples/Applications_human/fme/fme.c` |
| 62 | qcp | Applications_human/mergeablelist/sll_project_lib | `sll2array` | 29.48 | calls, heap, sll, struct, quantifiers | `/home/yangfp/QCIP/QCP_examples/Applications_human/mergeablelist/sll_project_lib.c` |
| 63 | qcp | Applications_human/minigmp/gmp | `mpz_abs_sub` | 45.26 | calls, heap, struct | `/home/yangfp/QCIP/QCP_examples/Applications_human/minigmp/gmp.c` |
| 64 | qcp | LLM_bench/Algorithms/coin_change/coin_change | `coinChange` | 44.90 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/coin_change/coin_change.c` |
| 65 | qcp | LLM_bench/Algorithms/dual_loop_quicksort/dual_loop_quicksort | `partition_two_loop` | 38.81 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/dual_loop_quicksort/dual_loop_quicksort.c` |
| 66 | qcp | LLM_bench/Algorithms/longest_increasing_subsequence/longest_increasing_subsequence | `lengthOfLIS` | 41.27 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/longest_increasing_subsequence/longest_increasing_subsequence.c` |
| 67 | qcp | LLM_bench/Algorithms/longest_nondecreasing_subsequence/longest_nondecreasing_subsequence | `lengthOfLNDS` | 37.10 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/longest_nondecreasing_subsequence/longest_nondecreasing_subsequence.c` |
| 68 | qcp | LLM_bench/Algorithms/manacher/manacher | `longestPalindrom` | 52.33 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/manacher/manacher.c` |
| 69 | qcp | LLM_bench/Algorithms/multiple_knapsack/multiple_knapsack | `multipleKnapsack` | 56.52 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/multiple_knapsack/multiple_knapsack.c` |
| 70 | qcp | LLM_bench/Algorithms/rmq/rmq | `build` | 44.49 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/rmq/rmq.c` |
| 71 | qcp | LLM_bench/Algorithms/sliding_window_maximum/sliding_window_maximum | `maxSlidingWindow` | 40.73 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/sliding_window_maximum/sliding_window_maximum.c` |
| 72 | qcp | LLM_bench/Algorithms/sort_point/sort_point | `cmp_polar_values` | 36.40 | heap, struct, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/sort_point/sort_point.c` |
| 73 | qcp | LLM_bench/Algorithms/super_piano/super_piano | `superPiano` | 66.55 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/super_piano/super_piano.c` |
| 74 | qcp | LLM_bench/Algorithms/zero_one_knapsack/zero_one_knapsack | `zeroOneKnapsack` | 44.36 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Algorithms/zero_one_knapsack/zero_one_knapsack.c` |
| 75 | qcp | LLM_bench/Data_structures/priority_queue/priority_queue | `pop` | 40.75 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Data_structures/priority_queue/priority_queue.c` |
| 76 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_copy_rel | `glibc_slist_clean_copy` | 32.29 | calls, heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_copy_rel.c` |
| 77 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_iter_back_2_rel | `glibc_slist_clean_iter_back_2` | 33.75 | heap, sll, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_iter_back_2_rel.c` |
| 78 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_merge_rel | `glibc_slist_clean_merge` | 34.44 | heap, sll, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_merge_rel.c` |
| 79 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_multi_merge_rel | `glibc_slist_clean_multi_merge` | 40.45 | heap, sll, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_multi_merge_rel.c` |
| 80 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_rev_append_twice_rel | `glibc_slist_clean_rev_append_twice` | 27.25 | heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_rev_append_twice_rel.c` |
| 81 | qcp | QCP_demos_LLM/2DCharPtrArray | `check_dict_case` | 39.49 | heap, nested-control, quantifiers | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/2DCharPtrArray.c` |
| 82 | qcp | QCP_demos_LLM/bubble_sort | `bubble_sort_alter` | 38.25 | heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/bubble_sort.c` |
| 83 | qcp | QCP_demos_LLM/dll_auto | `multi_merge` | 42.74 | calls, heap, dll, struct, nested-control | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/dll_auto.c` |
| 84 | qcp | QCP_demos_LLM/dll_auto | `multi_rev` | 32.42 | calls, heap, dll, struct, nested-control | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/dll_auto.c` |
| 85 | qcp | QCP_demos_LLM/dll_queue | `dequeue` | 25.25 | calls, heap, dll, struct | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/dll_queue.c` |
| 86 | qcp | QCP_demos_LLM/dll_queue | `enqueue` | 28.41 | calls, heap, dll, struct | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/dll_queue.c` |
| 87 | qcp | QCP_demos_LLM/int_array_merge_rel | `merge` | 40.13 | heap, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/int_array_merge_rel.c` |
| 88 | qcp | QCP_demos_LLM/sll | `append_long` | 31.96 | heap, sll, struct, nested-control, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll.c` |
| 89 | qcp | QCP_demos_LLM/sll_auto | `merge` | 27.40 | heap, sll, struct, nested-control | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_auto.c` |
| 90 | qcp | QCP_demos_LLM/sll_auto | `multi_append` | 32.60 | calls, heap, sll, struct, nested-control | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_auto.c` |
| 91 | qcp | QCP_demos_LLM/sll_insert_sort | `insertion` | 33.00 | heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_insert_sort.c` |
| 92 | qcp | QCP_demos_LLM/sll_merge_rel | `merge` | 38.03 | heap, sll, struct, nested-control, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_merge_rel.c` |
| 93 | qcp | QCP_demos_LLM/sll_merge_rel | `merge_sort3` | 37.65 | calls, heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_merge_rel.c` |
| 94 | qcp | QCP_demos_LLM/sll_split_while | `split_while` | 33.89 | heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_LLM/sll_split_while.c` |
| 95 | qcp | QCP_demos_human/sll_insert_sort | `insertion_sort` | 28.22 | calls, heap, sll, struct, quantifiers, Coq | `/home/yangfp/QCIP/QCP_examples/QCP_demos_human/sll_insert_sort.c` |
| 96 | qcp | QCP_demos_tutorial/float | `double_div_self_one_branch` | 6.05 | float | `/home/yangfp/QCIP/QCP_examples/QCP_demos_tutorial/float.c` |
| 97 | qcp | QCP_demos_tutorial/float | `double_eq_branch` | 6.05 | float | `/home/yangfp/QCIP/QCP_examples/QCP_demos_tutorial/float.c` |
| 98 | qcp | QCP_demos_tutorial/float | `double_ge_branch` | 6.05 | float | `/home/yangfp/QCIP/QCP_examples/QCP_demos_tutorial/float.c` |
| 99 | qcp | QCP_demos_tutorial/float | `float_lt_branch` | 6.05 | float | `/home/yangfp/QCIP/QCP_examples/QCP_demos_tutorial/float.c` |
| 100 | qcp | QCP_demos_tutorial/float | `float_neg_involution_branch` | 6.13 | float | `/home/yangfp/QCIP/QCP_examples/QCP_demos_tutorial/float.c` |
