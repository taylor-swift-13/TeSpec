
def precondition(input):
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    for item in nums:
        if not isinstance(item, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    nums = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    for item in output:
        if not isinstance(item, int):
            return False
    if sorted(nums) != sorted(output):
        return False
    
    def digit_sum(n):
        return sum(int(d) for d in str(abs(n)))
    
    for i in range(len(output) - 1):
        sum_i = digit_sum(output[i])
        sum_j = digit_sum(output[i + 1])
        if sum_i > sum_j:
            return False
    
    original_indices = {}
    for idx, val in enumerate(nums):
        if val not in original_indices:
            original_indices[val] = []
        original_indices[val].append(idx)
    
    value_counters = {}
    output_indices = []
    for val in output:
        if val not in value_counters:
            value_counters[val] = 0
        orig_idx = original_indices[val][value_counters[val]]
        value_counters[val] += 1
        output_indices.append(orig_idx)
    
    for i in range(len(output) - 1):
        sum_i = digit_sum(output[i])
        sum_j = digit_sum(output[i + 1])
        if sum_i == sum_j:
            if output_indices[i] > output_indices[i + 1]:
                return False
    
    return True

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
