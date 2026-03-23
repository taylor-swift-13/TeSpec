class value:
    pass

class VInt(value):
    def __init__(self, z: int):
        self.z = z

    def __eq__(self, other):
        return isinstance(other, VInt) and self.z == other.z

class VFloat(value):
    def __init__(self, r: float):
        self.r = r

    def __eq__(self, other):
        return isinstance(other, VFloat) and self.r == other.r

class VStr(value):
    def __init__(self, s: str):
        self.s = s

    def __eq__(self, other):
        return isinstance(other, VStr) and self.s == other.s

def replace_commas_with_dots(s: str) -> str:
    return s.replace(',', '.')

def R_of_string(s: str) -> float:
    try:
        return float(s)
    except ValueError:
        return 0.0

def num_of(v: value) -> float:
    if isinstance(v, VInt):
        return float(v.z)
    elif isinstance(v, VFloat):
        return float(v.r)
    elif isinstance(v, VStr):
        return R_of_string(replace_commas_with_dots(v.s))
    return 0.0

def compare_one_spec(a: value, b: value, res) -> bool:
    ra = num_of(a)
    rb = num_of(b)
    
    if ra == rb:
        return res is None
    elif rb < ra:
        return res == a
    elif ra < rb:
        return res == b
        
    return False

def _impl(a, b):
    num_a = float(str(a).replace(",", "."))
    num_b = float(str(b).replace(",", "."))
    if num_a == num_b:
        return None
    return a if num_a > num_b else b

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(compare_one_spec(*input, output))

def compare_one(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
