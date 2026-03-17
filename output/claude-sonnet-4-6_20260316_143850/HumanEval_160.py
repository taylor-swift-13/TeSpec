
def precondition(args):
    if len(args) != 2:
        return False
    operator, operand = args
    if not isinstance(operator, list) or not isinstance(operand, list):
        return False
    if len(operator) < 1:
        return False
    if len(operand) < 2:
        return False
    if len(operator) != len(operand) - 1:
        return False
    valid_ops = {'+', '-', '*', '//', '**'}
    for op in operator:
        if not isinstance(op, str) or op not in valid_ops:
            return False
    for num in operand:
        if not isinstance(num, int) or num < 0:
            return False
    return True


def postcondition(args, output):
    if not isinstance(output, (int, float)):
        return False
    operator, operand = args
    try:
        expr = str(operand[0])
        for op, num in zip(operator, operand[1:]):
            expr += ' ' + op + ' ' + str(num)
        expected = eval(expr)
        return output == expected
    except Exception:
        return False

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
