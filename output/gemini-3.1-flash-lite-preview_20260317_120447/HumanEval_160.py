
def precondition(input):
    operators, operands = input
    if not isinstance(operators, list) or not isinstance(operands, list):
        return False
    if len(operands) < 2 or len(operators) != len(operands) - 1:
        return False
    if not all(isinstance(x, int) and x >= 0 for x in operands):
        return False
    valid_ops = {'+', '-', '*', '//', '**'}
    if not all(op in valid_ops for op in operators):
        return False
    return True

def postcondition(input, output):
    return isinstance(output, (int, float))

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
