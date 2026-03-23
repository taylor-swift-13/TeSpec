def interp_op(op):
    if op == '+':
        return lambda x, y: x + y
    elif op == '-':
        return lambda x, y: x - y
    elif op == '*':
        return lambda x, y: x * y
    elif op == '/':
        return lambda x, y: x // y if y != 0 else 0
    elif op == '^':
        return lambda x, y: x ** y if y >= 0 else 0
    else:
        return lambda x, y: 0

def find_index_aux(p, l, n):
    for i in range(len(l)):
        if p(l[i]):
            return n + i
    return None

def find_index(p, l):
    return find_index_aux(p, l, 0)

def rfind_index(p, l):
    idx = find_index(p, list(reversed(l)))
    if idx is not None:
        return len(l) - 1 - idx
    return None

def nth(i, l, default):
    if 0 <= i < len(l):
        return l[i]
    return default

def eval_helper(ops, nums, fuel):
    if fuel == 0:
        return 0
    if len(nums) == 0:
        return 0
    if len(nums) == 1:
        return nums[0]
    
    idx = rfind_index(lambda c: c == '+' or c == '-', ops)
    if idx is not None:
        op = nth(idx, ops, ' ')
        return interp_op(op)(
            eval_helper(ops[:idx], nums[:idx+1], fuel - 1),
            eval_helper(ops[idx+1:], nums[idx+1:], fuel - 1)
        )
    
    idx = rfind_index(lambda c: c == '*' or c == '/', ops)
    if idx is not None:
        op = nth(idx, ops, ' ')
        return interp_op(op)(
            eval_helper(ops[:idx], nums[:idx+1], fuel - 1),
            eval_helper(ops[idx+1:], nums[idx+1:], fuel - 1)
        )
    
    idx = find_index(lambda c: c == '^', ops)
    if idx is not None:
        op = nth(idx, ops, ' ')
        return interp_op(op)(
            eval_helper(ops[:idx], nums[:idx+1], fuel - 1),
            eval_helper(ops[idx+1:], nums[idx+1:], fuel - 1)
        )
    
    return 0

def eval(ops, nums):
    return eval_helper(ops, nums, len(nums))

def do_algebra_impl(operators, operands):
    return eval(list(operators), operands)

def problem_160_pre(operators, operands):
    ops = list(operators)
    if len(ops) + 1 != len(operands):
        return False
    if len(ops) < 1:
        return False
    if len(operands) < 2:
        return False
    if not all(z >= 0 for z in operands):
        return False
    if not all(c in ['+', '-', '*', '/', '^'] for c in ops):
        return False
    return True

def problem_160_spec(operators, operands, result):
    return result == do_algebra_impl(operators, operands)

def _impl(operator, operand):
    exp = ""
    for i in range(len(operator)):
        exp += str(operand[i]) + operator[i]
    exp += str(operand[-1])
    return eval(exp)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_160_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_160_spec(*input, output))

def do_algebra(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
