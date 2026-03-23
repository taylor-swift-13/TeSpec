# Original version kept for reference:
# def nth(n, l, d):
#     """
#     Helper function to mimic Coq's nth function.
#     nth n l d returns the n-th element of list l, or d if n is out of bounds.
#     """
#     if 0 <= n < len(l):
#         return l[n]
#     return d
#
# def tri_spec(n, result):
#     """
#     Implements the Coq specification tri_spec.
#     
#     Definition tri_spec (n : nat) (result : list nat) : Prop :=
#       match n with
#       | 0 => result = [1]
#       | 1 => result = [1; 3]
#       | _ => 
#           exists (ans : list nat),
#           ans = [1; 3] /\
#           (forall i : nat, 2 <= i <= n ->
#             (Nat.even i = true -> nth (i-2) ans 0 + 1 + i / 2 = nth (i-1) ans 0) /\
#             (Nat.even i = false -> 
#               nth (i-2) ans 0 + nth (i-3) ans 0 + 1 + (i+1)/2 = nth (i-1) ans 0)) /\
#           result = ans
#       end.
#     """
#     if n == 0:
#         return result == [1]
#     if n == 1:
#         return result == [1, 3]
#     
#     # For n >= 2
#     # The spec explicitly requires ans = [1, 3] and result = ans.
#     # This means result must be exactly [1, 3].
#     ans = [1, 3]
#     if result != ans:
#         return False
#     
#     # Check the recurrence conditions for all i such that 2 <= i <= n
#     # The recurrence is checked against 'ans' which is fixed to [1, 3].
#     for i in range(2, n + 1):
#         if i % 2 == 0: # Nat.even i = true
#             # Condition: nth (i-2) ans 0 + 1 + i / 2 = nth (i-1) ans 0
#             term1 = nth(i-2, ans, 0)
#             term2 = 1
#             term3 = i // 2
#             lhs = term1 + term2 + term3
#             rhs = nth(i-1, ans, 0)
#             
#             if lhs != rhs:
#                 return False
#         else: # Nat.even i = false
#             # Condition: nth (i-2) ans 0 + nth (i-3) ans 0 + 1 + (i+1)/2 = nth (i-1) ans 0
#             term1 = nth(i-2, ans, 0)
#             term2 = nth(i-3, ans, 0)
#             term3 = 1
#             term4 = (i + 1) // 2
#             lhs = term1 + term2 + term3 + term4
#             rhs = nth(i-1, ans, 0)
#             
#             if lhs != rhs:
#                 return False
#                 
#     return True


def nth(n, l, d=0):
    if 0 <= n < len(l):
        return l[n]
    return d


def tri_spec(n, result):
    if n == 0:
        return result == [1]
    if n == 1:
        return result == [1, 3]

    ans = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            lhs = nth(i - 2, ans) + 1 + i // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False
        else:
            lhs = nth(i - 2, ans) + nth(i - 3, ans) + 1 + (i + 1) // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False
    return result == ans
