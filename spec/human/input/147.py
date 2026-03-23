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

def _orig_problem_147_pre(n):
    """
    Corresponds to Coq definition:
    Definition problem_147_pre (n : nat) : Prop := n > 0.
    """
    return n > 0

def _orig_problem_147_spec(n, output):
    """
    Corresponds to Coq definition:
    Definition problem_147_spec (n : nat) (output : nat) : Prop := ...
    
    Checks if output is the correct number of valid triples.
    """
    count_residue_0 = (n + 1) // 3
    count_residue_1 = n - count_residue_0

    def nCr_3(x):
        if x < 3:
            return 0
        return x * (x - 1) * (x - 2) // 6
    expected = nCr_3(count_residue_0) + nCr_3(count_residue_1)
    return output == expected

def problem_147_pre(n):
    return bool(_orig_problem_147_pre(n))

def problem_147_spec(n, output):
    return bool(_orig_problem_147_spec(n, output))
