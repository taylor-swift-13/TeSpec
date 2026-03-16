
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    # reject booleans (subclass of int)
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    n = input[0]
    # output must be an int (reject booleans)
    if isinstance(output, bool):
        return False
    if not isinstance(output, int):
        return False
    # compute expected value using fast matrix exponentiation for the linear recurrence
    if n == 0:
        expected = 0
    elif n == 1:
        expected = 0
    elif n == 2:
        expected = 1
    else:
        # recurrence matrix:
        # [1 1 1]
        # [1 0 0]
        # [0 1 0]
        def mat_mul(A, B):
            return [
                [A[0][0]*B[0][0] + A[0][1]*B[1][0] + A[0][2]*B[2][0],
                 A[0][0]*B[0][1] + A[0][1]*B[1][1] + A[0][2]*B[2][1],
                 A[0][0]*B[0][2] + A[0][1]*B[1][2] + A[0][2]*B[2][2]],
                [A[1][0]*B[0][0] + A[1][1]*B[1][0] + A[1][2]*B[2][0],
                 A[1][0]*B[0][1] + A[1][1]*B[1][1] + A[1][2]*B[2][1],
                 A[1][0]*B[0][2] + A[1][1]*B[1][2] + A[1][2]*B[2][2]],
                [A[2][0]*B[0][0] + A[2][1]*B[1][0] + A[2][2]*B[2][0],
                 A[2][0]*B[0][1] + A[2][1]*B[1][1] + A[2][2]*B[2][1],
                 A[2][0]*B[0][2] + A[2][1]*B[1][2] + A[2][2]*B[2][2]]
            ]
        def mat_pow(M, e):
            # identity 3x3
            R = [[1,0,0],[0,1,0],[0,0,1]]
            while e > 0:
                if e & 1:
                    R = mat_mul(R, M)
                M = mat_mul(M, M)
                e >>= 1
            return R
        def mat_vec_mul(M, v):
            return [
                M[0][0]*v[0] + M[0][1]*v[1] + M[0][2]*v[2],
                M[1][0]*v[0] + M[1][1]*v[1] + M[1][2]*v[2],
                M[2][0]*v[0] + M[2][1]*v[1] + M[2][2]*v[2]
            ]
        M = [[1,1,1],[1,0,0],[0,1,0]]
        # for n >= 2, [f(n), f(n-1), f(n-2)] = M^(n-2) * [f(2), f(1), f(0)] where base = [1,0,0]
        P = mat_pow(M, n-2)
        base = [1,0,0]
        res = mat_vec_mul(P, base)
        expected = res[0]
    return output == expected

def _impl(n: int):
    """The FibFib number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
    fibfib(0) == 0
    fibfib(1) == 0
    fibfib(2) == 1
    fibfib(n) == fibfib(n-1) + fibfib(n-2) + fibfib(n-3).
    Please write a function to efficiently compute the n-th element of the fibfib number sequence.
    0
    4
    24"""
    if n == 0 or n == 1:
        return 0
    elif n == 2:
        return 1
    a, b, c = 0, 0, 1
    for _ in range(3, n + 1):
        a, b, c = b, c, a + b + c
    return c

def fibfib(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
