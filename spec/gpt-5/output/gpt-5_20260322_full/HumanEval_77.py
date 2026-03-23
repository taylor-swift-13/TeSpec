def iscube_spec(a, res):
    """
    Implements the logic for:
    Definition iscube_spec (a : Z) (res : bool) : Prop :=
      res = true <-> exists k : Z, Z.pow k 3 = a.
      
    Returns True if 'res' correctly indicates whether 'a' is a perfect cube.
    """
    def is_perfect_cube(n):
        if n == 0:
            return True
        
        # Since (-k)^3 = -(k^3), n is a perfect cube if and only if abs(n) is a perfect cube.
        target = abs(n)
        
        # Binary search for the integer cube root
        low = 0
        # Upper bound estimation: 2^(ceil(bits/3)) covers the cube root
        high = 1 << ((target.bit_length() + 2) // 3)
        
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

    return res == is_perfect_cube(a)

def _impl(a):
    a = abs(a)
    return int(round(a ** (1. / 3))) ** 3 == a

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(iscube_spec(*input, output))

def iscube(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
