
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    ops, operands = input
    # must be lists
    if not isinstance(ops, list) or not isinstance(operands, list):
        return False
    # length constraints
    if len(ops) < 1 or len(operands) < 2:
        return False
    if len(ops) != len(operands) - 1:
        return False
    # validate operators
    allowed = {'+', '-', '*', '//', '**'}
    for o in ops:
        if not isinstance(o, str):
            return False
        if o not in allowed:
            return False
    # validate operands: non-negative integers
    for v in operands:
        if not isinstance(v, int):
            return False
        if v < 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    ops, operands = input
    # build expression string by interleaving operands and operators
    try:
        expr_parts = [str(operands[0])]
        for i, op in enumerate(ops):
            expr_parts.append(op)
            expr_parts.append(str(operands[i+1]))
        expr = ' '.join(expr_parts)
        expected = eval(expr)
    except Exception:
        return False
    return expected == output

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
