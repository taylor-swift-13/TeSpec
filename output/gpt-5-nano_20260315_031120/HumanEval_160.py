
def precondition(input):
    if not isinstance(input, (tuple, list)):
        return False
    if len(input) != 2:
        return False
    operator, operand = input
    if not isinstance(operator, list):
        return False
    if len(operator) < 1:
        return False
    allowed = {"+", "-", "*", "//", "**"}
    for op in operator:
        if not isinstance(op, str):
            return False
        if op not in allowed:
            return False
    if not isinstance(operand, list):
        return False
    if len(operand) < 2:
        return False
    if len(operator) != len(operand) - 1:
        return False
    for x in operand:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, (tuple, list)) or len(input) != 2:
        return False
    operator, operand = input
    if not isinstance(operator, list) or not isinstance(operand, list):
        return False
    if not precondition(input):
        return False

    try:
        nums = list(operand)
        ops = list(operator)
        i = 0
        # handle precedence: *, //, ** first
        while i < len(ops):
            if ops[i] in ("*", "//", "**"):
                a = nums[i]
                b = nums[i + 1]
                if ops[i] == "*":
                    r = a * b
                elif ops[i] == "//":
                    if b == 0:
                        return False
                    r = a // b
                else:
                    r = a ** b
                nums[i] = r
                del nums[i + 1]
                del ops[i]
            else:
                i += 1
        # then + and -
        res = nums[0]
        for idx, op in enumerate(ops):
            b = nums[idx + 1]
            if op == "+":
                res = res + b
            elif op == "-":
                res = res - b
            else:
                return False
        expected = res
    except Exception:
        return False

    if not isinstance(output, int):
        return False
    return output == expected

def _impl(operator, operand):
    """Given two lists operator, and operand. The first list has basic algebra operations, and 
    the second list is a list of integers. Use the two given lists to build the algebric 
    expression and return the evaluation of this expression.

    The basic algebra operations:
    Addition ( + ) 
    Subtraction ( - ) 
    Multiplication ( * ) 
    Floor division ( // ) 
    Exponentiation ( ** ) 

    Example:
    operator['+', '*', '-']
    array = [2, 3, 4, 5]
    result = 2 + 3 * 4 - 5
    => result = 9

    Note:
        The length of operator list is equal to the length of operand list minus one.
        Operand is a list of of non-negative integers.
        Operator list has at least one operator, and operand list has at least two operands."""
    exp = ""
    for i in range(len(operator)):
        exp += str(operand[i]) + operator[i]
    exp += str(operand[-1])
    return eval(exp)

def do_algebra(operator, operand):
    _input = (operator, operand)
    assert precondition(_input)
    _output = _impl(operator, operand)
    assert postcondition(_input, _output)
    return _output
