
def precondition(input):
    if not isinstance(input, (tuple, list)) or len(input) != 2:
        return False
    operator, operand = input
    if not isinstance(operator, list) or not isinstance(operand, list):
        return False
    if len(operator) < 1:
        return False
    if len(operand) < 2:
        return False
    if len(operator) != len(operand) - 1:
        return False
    allowed = {"+", "-", "*", "//", "**"}
    for op in operator:
        if not isinstance(op, str) or op not in allowed:
            return False
    for v in operand:
        if not isinstance(v, int) or v < 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    operator, operand = input
    def evaluate(op, arr):
        # Shunting-yard to RPN
        def prec(o):
            if o == '**':
                return 3
            if o in ('*', '//'):
                return 2
            if o in ('+', '-'):
                return 1
            return 0

        def assoc(o):
            return 'right' if o == '**' else 'left'

        output_queue = []
        operator_stack = []
        for i, val in enumerate(arr):
            output_queue.append(val)
            if i < len(op):
                o1 = op[i]
                while operator_stack:
                    o2 = operator_stack[-1]
                    if ((assoc(o1) == 'left' and prec(o1) <= prec(o2)) or
                        (assoc(o1) == 'right' and prec(o1) < prec(o2))):
                        output_queue.append(operator_stack.pop())
                    else:
                        break
                operator_stack.append(o1)
        while operator_stack:
            output_queue.append(operator_stack.pop())

        # Evaluate RPN
        stack = []
        for tok in output_queue:
            if isinstance(tok, int):
                stack.append(tok)
            else:
                if len(stack) < 2:
                    raise ValueError("Invalid expression")
                b = stack.pop()
                a = stack.pop()
                if tok == '+':
                    stack.append(a + b)
                elif tok == '-':
                    stack.append(a - b)
                elif tok == '*':
                    stack.append(a * b)
                elif tok == '//':
                    stack.append(a // b)
                elif tok == '**':
                    stack.append(a ** b)
                else:
                    raise ValueError("Unknown operator")
        if len(stack) != 1:
            raise ValueError("Invalid expression")
        return stack[0]

    try:
        expected = evaluate(operator, operand)
    except Exception:
        return False

    if not isinstance(output, int):
        return False
    return output == expected

def _impl(operator, operand):
    """
    Given two lists operator, and operand. The first list has basic algebra operations, and 
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
        Operator list has at least one operator, and operand list has at least two operands.
    """
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
