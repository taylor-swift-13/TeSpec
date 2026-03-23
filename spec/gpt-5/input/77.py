def _orig_iscube_spec(a, output):
    """
    Implements the logic for:
    Definition iscube_spec (a : Z) (output : bool) : Prop :=
      output = true <-> exists k : Z, Z.pow k 3 = a.
      
    Returns True if 'output' correctly indicates whether 'a' is a perfect cube.
    """

    def is_perfect_cube(n):
        if n == 0:
            return True
        target = abs(n)
        low = 0
        high = 1 << (target.bit_length() + 2) // 3
        while low <= high:
            mid = (low + high) // 2
            cube = mid * mid * mid
            if cube == target:
                return True
            elif cube < target:
                low = mid + 1
            else:
                high = mid - 1
        return False
    return output == is_perfect_cube(a)

def iscube_spec(a, output):
    return bool(_orig_iscube_spec(a, output))
