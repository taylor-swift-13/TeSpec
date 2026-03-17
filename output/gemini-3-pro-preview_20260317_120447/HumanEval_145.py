
def precondition(args):
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    nums = args[0]
    return isinstance(nums, list) and all(isinstance(x, int) for x in nums)

def postcondition(args, output):
    nums = args[0]
    if not isinstance(output, list) or len(output) != len(nums):
        return False

    def get_digit_sum(n):
        return sum(int(d) for d in str(abs(n)))

    indexed_nums = []
    for i, x in enumerate(nums):
        indexed_nums.append((get_digit_sum(x), i, x))
    
    # Sort by digit sum, then by original index to ensure stability
    indexed_nums.sort(key=lambda item: (item[0], item[1]))
    
    expected = [item[2] for item in indexed_nums]
    return output == expected

def _impl(nums):
    """Write a function which sorts the given list of integers
    in ascending order according to the sum of their digits.
    Note: if there are several items with similar sum of their digits,
    order them based on their index in original list.

    For example:"""
    def weight(x):
        x_list = list(str(x))
        if x_list[0] == "-":
            x_list = x_list[1:]
            x_list = list(map(int, x_list))
            x_list[0] = -x_list[0]
        else:
            x_list = list(map(int, x_list))
        return sum(x_list)
    return sorted(nums, key=weight)

def order_by_points(nums):
    _input = (nums,)
    assert precondition(_input)
    _output = _impl(nums)
    assert postcondition(_input, _output)
    return _output
