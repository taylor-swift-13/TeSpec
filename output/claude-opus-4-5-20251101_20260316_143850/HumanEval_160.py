
def precondition(args):
    if len(args) != 2:
        return False
    
    operator, operand = args
    
    # Check that operator is a list
    if not isinstance(operator, list):
        return False
    
    # Check that operand is a list
    if not isinstance(operand, list):
        return False
    
    # Operator list has at least one operator
    if len(operator) < 1:
        return False
    
    # Operand list has at least two operands
    if len(operand) < 2:
        return False
    
    # The length of operator list is equal to the length of operand list minus one
    if len(operator) != len(operand) - 1:
        return False
    
    # All operators must be valid basic algebra operations
    valid_operators = {'+', '-', '*', '//', '**'}
    for op in operator:
        if not isinstance(op, str):
            return False
        if op not in valid_operators:
            return False
    
    # Operand is a list of non-negative integers
    for num in operand:
        if not isinstance(num, int):
            return False
        if isinstance(num, bool):
            return False
        if num < 0:
            return False
    
    return True


def postcondition(args, output):
    operator, operand = args
    
    # Output should be an integer
    if not isinstance(output, int):
        return False
    
    # Verify by building and evaluating the expression
    if len(operand) == 0:
        return False
    
    # Build the expression string
    expression = str(operand[0])
    for i, op in enumerate(operator):
        expression += ' ' + op + ' ' + str(operand[i + 1])
    
    # Evaluate the expression
    try:
        expected = eval(expression)
        return output == expected
    except:
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
