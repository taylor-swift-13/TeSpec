
def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 2:
            return False
        ops, operands = input
        if not isinstance(ops, (list, tuple)) or not isinstance(operands, (list, tuple)):
            return False
        if len(ops) < 1 or len(operands) < 2:
            return False
        if len(ops) != len(operands) - 1:
            return False
        allowed = {"+", "-", "*", "//", "**"}
        for op in ops:
            if not isinstance(op, str) or op not in allowed:
                return False
        for v in operands:
            if not isinstance(v, int) or isinstance(v, bool) or v < 0:
                return False

        def power_chain_evaluates_to_zero(op_list, vals, j):
            # Returns True if the value of vals[j] ** vals[j+1] ** ... (right-associative)
            # equals 0, considering only contiguous '**' starting at operator index j.
            if j >= len(vals):
                return False
            if j >= len(op_list) or op_list[j] != "**":
                return vals[j] == 0
            exp_is_zero = power_chain_evaluates_to_zero(op_list, vals, j + 1)
            if vals[j] == 0:
                # 0 ** 0 == 1 (not zero), 0 ** positive == 0
                return not exp_is_zero
            else:
                # positive base to any exponent is positive (not zero)
                return False

        # Check for floor-division by a zero effective divisor
        for i, op in enumerate(ops):
            if op == "//":
                j = i + 1
                if j >= len(operands):
                    return False
                # If the next operator is '**', the divisor is the result of the power chain starting at j
                if j < len(ops) and ops[j] == "**":
                    if power_chain_evaluates_to_zero(ops, operands, j):
                        return False
                else:
                    if operands[j] == 0:
                        return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        ops, operands = input
        # Basic type check on output: expect an int (bool is a subclass of int, exclude it)
        if not isinstance(output, int) or isinstance(output, bool):
            return False

        # Shunting-yard to handle precedence and associativity
        precedence = {"+": 1, "-": 1, "*": 2, "//": 2, "**": 3}
        right_assoc = {"**"}
        tokens = []
        n = len(operands)
        for i in range(n):
            tokens.append(operands[i])
            if i < len(ops):
                tokens.append(ops[i])

        out_queue = []
        op_stack = []

        def is_op(t):
            return isinstance(t, str) and t in precedence

        for t in tokens:
            if isinstance(t, int):
                out_queue.append(t)
            elif is_op(t):
                p1 = precedence[t]
                a1_right = t in right_assoc
                while op_stack:
                    top = op_stack[-1]
                    if not is_op(top):
                        break
                    p2 = precedence[top]
                    if (not a1_right and p1 <= p2) or (a1_right and p1 < p2):
                        out_queue.append(op_stack.pop())
                    else:
                        break
                op_stack.append(t)
            else:
                return False
        while op_stack:
            out_queue.append(op_stack.pop())

        stack = []
        for t in out_queue:
            if isinstance(t, int):
                stack.append(t)
            else:
                if len(stack) < 2:
                    return False
                b = stack.pop()
                a = stack.pop()
                if t == "+":
                    stack.append(a + b)
                elif t == "-":
                    stack.append(a - b)
                elif t == "*":
                    stack.append(a * b)
                elif t == "//":
                    # Assume precondition avoids zero division
                    stack.append(a // b)
                elif t == "**":
                    stack.append(a ** b)
                else:
                    return False
        if len(stack) != 1:
            return False
        expected = stack[0]
        return expected == output
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
