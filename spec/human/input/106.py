def problem_106_pre(n):
    return True

def problem_106_spec(n, l):
    # Helper function to compute factorial of x
    def fact(x):
        res = 1
        for k in range(1, x + 1):
            res *= k
        return res

    # Helper function to compute sum from 1 to x
    # Corresponds to let sum := fun i => Nat.div (i * (i + 1)) 2
    def sum_nat(x):
        return (x * (x + 1)) // 2

    # Helper function to check if x is even
    def even(x):
        return x % 2 == 0

    # Check if the length of list l is n
    if len(l) != n:
        return False

    # Check the condition for each index i from 1 to n
    # forall i, 1 <= i -> i <= n -> nth_error l (i - 1) = Some ...
    for i in range(1, n + 1):
        # In Python, list indices are 0-based, so index is i - 1
        actual_value = l[i - 1]
        
        if even(i):
            expected_value = fact(i)
        else:
            expected_value = sum_nat(i)
            
        if actual_value != expected_value:
            return False
            
    return True
