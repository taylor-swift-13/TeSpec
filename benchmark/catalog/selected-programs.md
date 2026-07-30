# Four-class benchmark program shortlist

> Status: static shortlist. A program enters the released benchmark only
> after its reference semantics, candidate labels, and witnesses have
> passed the semantic audit described in `../DESIGN.zh-CN.md`.

## Summary

- Target functions: 100
- Source families: 91
- Multi-call targets: 60
- Native `float`/`double` targets: 0
- Float-model targets: 1
- Heap targets: 100
- Singly linked targets: 10
- Doubly linked targets: 2
- Quantified specifications: 91

## Programs

| # | Corpus | Family | Target | Score | Main features | Source |
|---:|---|---|---|---:|---|---|
| 1 | cav | add_binary_strings | `add_binary_strings` | 52.56 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/add_binary_strings.c` |
| 2 | cav | array_is_sorted_csv | `array_is_sorted_csv` | 43.43 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/array_is_sorted_csv.c` |
| 3 | cav | array_min_csv | `array_min_csv` | 45.84 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/array_min_csv.c` |
| 4 | cav | aug_all_multiple_array_003 | `aug_all_multiple_array_003` | 37.72 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/aug_all_multiple_array_003.c` |
| 5 | cav | aug_all_multiple_stream_003 | `aug_all_multiple_stream_003` | 33.85 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/aug_all_multiple_stream_003.c` |
| 6 | cav | aug_sum_prefix_array_002 | `aug_sum_prefix_array_002` | 34.36 | heap, nested-control, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/aug_sum_prefix_array_002.c` |
| 7 | cav | contains_duplicate_csv | `contains_duplicate_csv` | 43.37 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/contains_duplicate_csv.c` |
| 8 | cav | count_good_pairs_csv | `count_good_pairs_csv` | 43.49 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/count_good_pairs_csv.c` |
| 9 | cav | decode_xored_array_csv | `decode_xored_array_csv` | 52.80 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/decode_xored_array_csv.c` |
| 10 | cav | defang_ip_address | `defang_ip_address` | 35.91 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/defang_ip_address.c` |
| 11 | cav | ex_anagram_count | `ex_anagram_count` | 75.41 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/ex_anagram_count.c` |
| 12 | cav | ex_binary_search_index_csv | `ex_binary_search_index_csv` | 44.55 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/ex_binary_search_index_csv.c` |
| 13 | cav | ex_matrix_row_sum | `ex_matrix_row_sum` | 34.85 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/ex_matrix_row_sum.c` |
| 14 | cav | merge_sorted_arrays | `merge_sorted_arrays` | 34.69 | heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/algo/merge_sorted_arrays.c` |
| 15 | cav | p006_parse_nested_parens | `p006_parse_nested_parens` | 48.40 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p006_parse_nested_parens.c` |
| 16 | cav | p010_make_palindrome | `p010_make_palindrome` | 41.95 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p010_make_palindrome.c` |
| 17 | cav | p015_string_sequence | `p015_string_sequence` | 36.24 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p015_string_sequence.c` |
| 18 | cav | p017_parse_music | `p017_parse_music` | 61.91 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p017_parse_music.c` |
| 19 | cav | p018_how_many_times | `p018_how_many_times` | 34.29 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p018_how_many_times.c` |
| 20 | cav | p026_remove_duplicates | `p026_remove_duplicates` | 48.51 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p026_remove_duplicates.c` |
| 21 | cav | p033_sort_third | `p033_sort_third` | 41.67 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p033_sort_third.c` |
| 22 | cav | p034_unique | `p034_unique` | 35.89 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p034_unique.c` |
| 23 | cav | p058_common | `p058_common` | 40.82 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p058_common.c` |
| 24 | cav | p065_circular_shift | `p065_circular_shift` | 46.47 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p065_circular_shift.c` |
| 25 | cav | p067_fruit_distribution | `p067_fruit_distribution` | 37.42 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p067_fruit_distribution.c` |
| 26 | cav | p069_search | `p069_search` | 36.85 | calls, heap, nested-control, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p069_search.c` |
| 27 | cav | p070_strange_sort_list | `p070_strange_sort_list` | 41.59 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p070_strange_sort_list.c` |
| 28 | cav | p079_decimal_to_binary | `p079_decimal_to_binary` | 39.17 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p079_decimal_to_binary.c` |
| 29 | cav | p084_solve | `p084_solve` | 40.30 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p084_solve.c` |
| 30 | cav | p088_sort_array | `p088_sort_array` | 42.48 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p088_sort_array.c` |
| 31 | cav | p096_count_up_to | `p096_count_up_to` | 41.80 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p096_count_up_to.c` |
| 32 | cav | p104_unique_digits | `p104_unique_digits` | 35.89 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p104_unique_digits.c` |
| 33 | cav | p107_even_odd_palindrome | `p107_even_odd_palindrome` | 36.76 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p107_even_odd_palindrome.c` |
| 34 | cav | p116_sort_array | `p116_sort_array` | 67.69 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p116_sort_array.c` |
| 35 | cav | p118_get_closest_vowel | `p118_get_closest_vowel` | 40.68 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p118_get_closest_vowel.c` |
| 36 | cav | p119_match_parens | `p119_match_parens` | 58.39 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p119_match_parens.c` |
| 37 | cav | p120_maximum | `p120_maximum` | 43.71 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p120_maximum.c` |
| 38 | cav | p124_valid_date | `p124_valid_date` | 37.96 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p124_valid_date.c` |
| 39 | cav | p130_tri | `p130_tri` | 35.32 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p130_tri.c` |
| 40 | cav | p132_is_nested | `p132_is_nested` | 35.13 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p132_is_nested.c` |
| 41 | cav | p136_largest_smallest_integers | `p136_largest_smallest_integers` | 36.52 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p136_largest_smallest_integers.c` |
| 42 | cav | p140_fix_spaces | `p140_fix_spaces` | 42.63 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p140_fix_spaces.c` |
| 43 | cav | p141_file_name_check | `p141_file_name_check` | 59.49 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p141_file_name_check.c` |
| 44 | cav | p143_words_in_sentence | `p143_words_in_sentence` | 46.31 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p143_words_in_sentence.c` |
| 45 | cav | p144_simplify | `p144_simplify` | 38.01 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p144_simplify.c` |
| 46 | cav | p145_order_by_points | `p145_order_by_points` | 53.14 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p145_order_by_points.c` |
| 47 | cav | p152_compare | `p152_compare` | 39.18 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p152_compare.c` |
| 48 | cav | p155_even_odd_count | `p155_even_odd_count` | 37.40 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p155_even_odd_count.c` |
| 49 | cav | p156_int_to_mini_romank | `append_roman_digit` | 35.73 | heap, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p156_int_to_mini_romank.c` |
| 50 | cav | p161_solve | `p161_solve` | 40.04 | calls, heap, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p161_solve.c` |
| 51 | cav | p163_generate_integers | `p163_generate_integers` | 36.95 | calls, heap, struct, nested-control, quantifiers, Coq | `/home/yangfp/CAV/main/CAV-bench/input/humaneval/p163_generate_integers.c` |
| 52 | qcip_output | IP/STSUseFlag/reports | `STSUseFlag` | 35.02 | heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/IP/STSUseFlag/reports/input_snapshots/IP_STSUseFlag.annotated.c` |
| 53 | qcip_output | IP/StructFilter | `StructFilter` | 43.72 | heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/IP/StructFilter/source/IP_StructFilter.c` |
| 54 | qcip_output | IP/WheelFriction | `WheelFriction` | 46.92 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/IP/WheelFriction/source/IP_WheelFriction.c` |
| 55 | qcip_output | SAMCodeSynthesis/B_TcProcess | `B_TcProcessFun` | 51.94 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/B_TcProcess/source/IP_B_TcProcess.c` |
| 56 | qcip_output | SAMCodeSynthesis/JetCtrlSend | `JetCtrlSendFun` | 40.56 | calls, heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/JetCtrlSend/source/IP_JetCtrlSend.c` |
| 57 | qcip_output | SAMCodeSynthesis/ThrusterCtrlLogic | `ThrusterCtrlLogicFun` | 47.62 | heap, struct, quantifiers, Coq | `/home/yangfp/QCIP/OUTPUT/SAMCodeSynthesis/ThrusterCtrlLogic/source/IP_ThrusterCtrlLogic.c` |
| 58 | qcp | Applications_human/convex_hull/andrew_monotone_chain | `andrew_build_from_sorted` | 64.62 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/andrew_monotone_chain.c` |
| 59 | qcp | Applications_human/convex_hull/andrew_monotone_chain | `partition_xy_points` | 45.19 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/andrew_monotone_chain.c` |
| 60 | qcp | Applications_human/convex_hull/graham_scan | `build_hull_from_sorted_tail` | 55.45 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/graham_scan.c` |
| 61 | qcp | Applications_human/convex_hull/graham_scan | `graham_scan` | 57.22 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/graham_scan.c` |
| 62 | qcp | Applications_human/convex_hull/graham_scan_dedup | `build_hull_from_sorted_tail_dedup` | 56.17 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/graham_scan_dedup.c` |
| 63 | qcp | Applications_human/convex_hull/graham_scan_dedup | `dedup_points_and_find_leftmost` | 59.56 | calls, heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/Applications_human/convex_hull/graham_scan_dedup.c` |
| 64 | qcp | Applications_human/fme/fme | `generate_new_constr` | 50.35 | calls, heap, struct, nested-control, quantifiers | `runtime/qcip/QCP_examples/Applications_human/fme/fme.c` |
| 65 | qcp | Applications_human/fme/fme | `real_shadow` | 47.05 | calls, heap, struct, nested-control, quantifiers | `runtime/qcip/QCP_examples/Applications_human/fme/fme.c` |
| 66 | qcp | Applications_human/minigmp/gmp | `mpz_abs_add` | 36.01 | calls, heap, struct | `runtime/qcip/QCP_examples/Applications_human/minigmp/gmp.c` |
| 67 | qcp | Applications_human/minigmp/gmp | `mpz_abs_sub` | 45.26 | calls, heap, struct | `runtime/qcip/QCP_examples/Applications_human/minigmp/gmp.c` |
| 68 | qcp | LLM_bench/Algorithms/coin_change/coin_change | `coinChange` | 44.90 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/coin_change/coin_change.c` |
| 69 | qcp | LLM_bench/Algorithms/dual_loop_quicksort/dual_loop_quicksort | `partition_two_loop` | 38.81 | calls, heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/dual_loop_quicksort/dual_loop_quicksort.c` |
| 70 | qcp | LLM_bench/Algorithms/longest_increasing_subsequence/longest_increasing_subsequence | `lengthOfLIS` | 41.27 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/longest_increasing_subsequence/longest_increasing_subsequence.c` |
| 71 | qcp | LLM_bench/Algorithms/longest_nondecreasing_subsequence/longest_nondecreasing_subsequence | `lengthOfLNDS` | 37.10 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/longest_nondecreasing_subsequence/longest_nondecreasing_subsequence.c` |
| 72 | qcp | LLM_bench/Algorithms/manacher/manacher | `longestPalindrom` | 52.33 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/manacher/manacher.c` |
| 73 | qcp | LLM_bench/Algorithms/multiple_knapsack/multiple_knapsack | `multipleKnapsack` | 56.52 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/multiple_knapsack/multiple_knapsack.c` |
| 74 | qcp | LLM_bench/Algorithms/rmq/rmq | `build` | 44.49 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/rmq/rmq.c` |
| 75 | qcp | LLM_bench/Algorithms/sliding_window_maximum/sliding_window_maximum | `maxSlidingWindow` | 40.73 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/sliding_window_maximum/sliding_window_maximum.c` |
| 76 | qcp | LLM_bench/Algorithms/sort_point/sort_point | `cmp_polar_values` | 36.40 | heap, struct, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/sort_point/sort_point.c` |
| 77 | qcp | LLM_bench/Algorithms/sort_point/sort_point | `partition_points` | 35.93 | calls, heap, struct, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/sort_point/sort_point.c` |
| 78 | qcp | LLM_bench/Algorithms/super_piano/super_piano | `superPiano` | 66.55 | calls, heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/super_piano/super_piano.c` |
| 79 | qcp | LLM_bench/Algorithms/zero_one_knapsack/zero_one_knapsack | `zeroOneKnapsack` | 44.36 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Algorithms/zero_one_knapsack/zero_one_knapsack.c` |
| 80 | qcp | LLM_bench/Data_structures/priority_queue/priority_queue | `pop` | 40.75 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Data_structures/priority_queue/priority_queue.c` |
| 81 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_copy_rel | `glibc_slist_clean_copy` | 32.29 | calls, heap, sll, struct, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_copy_rel.c` |
| 82 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_iter_back_2_rel | `glibc_slist_clean_iter_back_2` | 33.75 | heap, sll, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_iter_back_2_rel.c` |
| 83 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_merge_rel | `glibc_slist_clean_merge` | 34.44 | heap, sll, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_merge_rel.c` |
| 84 | qcp | LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_multi_merge_rel | `glibc_slist_clean_multi_merge` | 40.45 | heap, sll, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/LLM_bench/Engineering/glibc_slist/glibc_slist_rel/glibc_slist_multi_merge_rel.c` |
| 85 | qcp | QCP_demos_LLM/2DCharPtrArray | `check_dict_case` | 39.49 | heap, nested-control, quantifiers | `runtime/qcip/QCP_examples/QCP_demos_LLM/2DCharPtrArray.c` |
| 86 | qcp | QCP_demos_LLM/bubble_sort | `bubble_sort_alter` | 38.25 | heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/bubble_sort.c` |
| 87 | qcp | QCP_demos_LLM/bubble_sort | `bubble_sort_alter1` | 37.53 | heap, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/bubble_sort.c` |
| 88 | qcp | QCP_demos_LLM/dll_auto | `multi_merge` | 42.74 | calls, heap, dll, struct, nested-control | `runtime/qcip/QCP_examples/QCP_demos_LLM/dll_auto.c` |
| 89 | qcp | QCP_demos_LLM/dll_auto | `multi_rev` | 32.42 | calls, heap, dll, struct, nested-control | `runtime/qcip/QCP_examples/QCP_demos_LLM/dll_auto.c` |
| 90 | qcp | QCP_demos_LLM/int_array_merge_rel | `merge` | 40.13 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/int_array_merge_rel.c` |
| 91 | qcp | QCP_demos_LLM/kmp_rel | `constr` | 30.36 | calls, heap, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/kmp_rel.c` |
| 92 | qcp | QCP_demos_LLM/sll | `append_long` | 31.96 | heap, sll, struct, nested-control, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll.c` |
| 93 | qcp | QCP_demos_LLM/sll_auto | `multi_append` | 32.60 | calls, heap, sll, struct, nested-control | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll_auto.c` |
| 94 | qcp | QCP_demos_LLM/sll_insert_sort | `insertion` | 33.00 | heap, sll, struct, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll_insert_sort.c` |
| 95 | qcp | QCP_demos_LLM/sll_merge_rel | `merge` | 38.03 | heap, sll, struct, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll_merge_rel.c` |
| 96 | qcp | QCP_demos_LLM/sll_merge_rel | `merge_sort3` | 37.65 | calls, heap, sll, struct, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll_merge_rel.c` |
| 97 | qcp | QCP_demos_LLM/sll_split_while | `split_while` | 33.89 | heap, sll, struct, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sll_split_while.c` |
| 98 | qcp | QCP_demos_LLM/sortArray2 | `sortArray` | 32.21 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sortArray2.c` |
| 99 | qcp | QCP_demos_LLM/sortArray3 | `sortArray` | 34.18 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_LLM/sortArray3.c` |
| 100 | qcp | QCP_demos_human/sortArray | `sortArray` | 34.56 | heap, nested-control, quantifiers, Coq | `runtime/qcip/QCP_examples/QCP_demos_human/sortArray.c` |
