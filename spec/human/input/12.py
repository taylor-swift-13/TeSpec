def problem_12_pre(input):
    return True

# def problem_12_spec(input, output):
#     if len(input) == 0:
#         return output is None
#     if output is None:
#         return False
#
#     def nth_error(lst, n):
#         if 0 <= n < len(lst):
#             return lst[n]
#         return None
#
#     for i in range(len(input)):
#         out = input[i]
#         if output == out:
#             if i < len(input) and nth_error(input, i) == out:
#                 
#                 # (forall j, j < List.length input -> exists s, nth_error input j = Some s -> String.length s <= String.length out)
#                 cond1 = True
#                 for j in range(len(input)):
#                     # We evaluate the existential by checking the intended witness first
#                     s = nth_error(input, j)
#                     if s is not None:
#                         premise = (nth_error(input, j) == s)
#                         conclusion = (len(s) <= len(out))
#                         implication = (not premise) or conclusion
#                         
#                         # If the intended witness doesn't satisfy the implication, 
#                         # the Coq spec's existential allows picking a non-matching string.
#                         if not implication:
#                             # Pick a witness that makes the premise false
#                             alt_s = s + "_alt"
#                             alt_premise = (nth_error(input, j) == alt_s)
#                             alt_conclusion = (len(alt_s) <= len(out))
#                             alt_implication = (not alt_premise) or alt_conclusion
#                             if not alt_implication:
#                                 cond1 = False
#                                 break
#
#                 if not cond1:
#                     continue
#
#                 # (forall j, j < i -> exists s, nth_error input j = Some s -> String.length s < String.length out)
#                 cond2 = True
#                 for j in range(i):
#                     s = nth_error(input, j)
#                     if s is not None:
#                         premise = (nth_error(input, j) == s)
#                         conclusion = (len(s) < len(out))
#                         implication = (not premise) or conclusion
#                         
#                         if not implication:
#                             alt_s = s + "_alt"
#                             alt_premise = (nth_error(input, j) == alt_s)
#                             alt_conclusion = (len(alt_s) < len(out))
#                             alt_implication = (not alt_premise) or alt_conclusion
#                             if not alt_implication:
#                                 cond2 = False
#                                 break
#
#                 if cond1 and cond2:
#                     return True
#
#     return False

def problem_12_spec(input, output):
    if len(input) == 0:
        return output is None
    if output is None:
        return False
    for item in input:
        if item == output:
            return True
    return False
