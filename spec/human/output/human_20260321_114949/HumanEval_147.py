def a_val(i):
    """
    Corresponds to Coq definition:
    Definition a_val (i : nat) : Z :=
      let i_z := Z.of_nat i in
      i_z * i_z - i_z + 1.
    """
    return i * i - i + 1

def is_valid_triple(n, i, j, k):
    """
    Corresponds to Coq definition:
    Definition is_valid_triple (n i j k : nat) : Prop :=
      (1 <= i)%nat /\ (i < j)%nat /\ (j < k)%nat /\ (k <= n)%nat /\
      (a_val i + a_val j + a_val k) mod 3 = 0.
    """
    return (1 <= i < j < k <= n) and ((a_val(i) + a_val(j) + a_val(k)) % 3 == 0)

def problem_147_pre(n):
    """
    Corresponds to Coq definition:
    Definition problem_147_pre (n : nat) : Prop := n > 0.
    """
    return n > 0

def problem_147_spec(n, output):
    """
    Corresponds to Coq definition:
    Definition problem_147_spec (n : nat) (output : nat) : Prop := ...
    
    Checks if output is the correct number of valid triples.
    """
    # Analysis of a_val(x) mod 3:
    # x % 3 == 0 => a_val(x) = 0 - 0 + 1 = 1 (mod 3)
    # x % 3 == 1 => a_val(x) = 1 - 1 + 1 = 1 (mod 3)
    # x % 3 == 2 => a_val(x) = 4 - 2 + 1 = 3 = 0 (mod 3)
    
    # We need a_val(i) + a_val(j) + a_val(k) == 0 (mod 3).
    # Since residues are only 0 and 1, the only valid combinations are:
    # 0 + 0 + 0 = 0
    # 1 + 1 + 1 = 3 = 0
    
    # Count how many x in 1..n have a_val(x) % 3 == 0 (i.e., x % 3 == 2)
    # x values: 2, 5, 8, ...
    count_residue_0 = (n + 1) // 3
    
    # Count how many x in 1..n have a_val(x) % 3 == 1 (i.e., x % 3 != 2)
    count_residue_1 = n - count_residue_0
    
    def nCr_3(x):
        if x < 3:
            return 0
        return x * (x - 1) * (x - 2) // 6
    
    expected = nCr_3(count_residue_0) + nCr_3(count_residue_1)
    
    return output == expected

def _impl(n):
    if n <= 2: return False
    one_cnt = 1 + (n - 2) // 3 * 2 + (n - 2) % 3
    zero_cnt = n - one_cnt
    return one_cnt * (one_cnt - 1) * (one_cnt - 2) // 6 + zero_cnt * (zero_cnt - 1) * (zero_cnt - 2) // 6

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_147_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_147_spec(*input, output))

def get_max_triples(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
