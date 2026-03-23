def _orig_choose_num_spec(x: int, y: int, output: int) -> bool:
    """
    Implementation of the Coq specification:
    Definition choose_num_spec (x y output : Z) : Prop :=
      (output = -1 <-> (forall n : Z, x <= n <= y -> Z.Odd n)) /      (output <> -1 -> 
         Z.Even output /\\ 
         x <= output <= y /\\ 
         (forall n : Z, x <= n <= y -> Z.Even n -> n <= output)).
    """

    def is_even(n: int) -> bool:
        return n % 2 == 0

    def is_odd(n: int) -> bool:
        return n % 2 != 0
    integers_in_range = range(x, y + 1)
    all_odd = all((is_odd(n) for n in integers_in_range))
    if (output == -1) != all_odd:
        return False
    if output != -1:
        if not is_even(output):
            return False
        if not x <= output <= y:
            return False
        for n in integers_in_range:
            if is_even(n):
                if n > output:
                    return False
    return True

def choose_num_spec(x, y, output):
    return bool(_orig_choose_num_spec(x, y, output))
