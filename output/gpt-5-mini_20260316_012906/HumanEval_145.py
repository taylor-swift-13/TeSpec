
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    for x in nums:
        # reject booleans, accept integers (including negatives)
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    from collections import Counter, defaultdict
    if not precondition(input):
        return False
    nums = input[0]
    out = output
    if not isinstance(out, (list, tuple)):
        return False
    if len(out) != len(nums):
        return False
    for x in out:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    # multiset equality
    if Counter(nums) != Counter(out):
        return False
    # digit sum function: sum of decimal digits of absolute value
    def digit_sum(n):
        n = abs(n)
        s = 0
        if n == 0:
            return 0
        while n:
            s += n % 10
            n //= 10
        return s
    # non-decreasing by digit sum
    ds_out = [digit_sum(x) for x in out]
    for i in range(len(ds_out) - 1):
        if ds_out[i] > ds_out[i+1]:
            return False
    # stability: for equal digit sums, relative order must match original indices
    positions = defaultdict(list)
    for idx, val in enumerate(nums):
        positions[val].append(idx)
    mapped_indices = []
    for val in out:
        if not positions[val]:
            return False
        mapped_indices.append(positions[val].pop(0))
    # check that for any pair with equal digit sum, indices are increasing
    for i in range(len(out)):
        for j in range(i+1, len(out)):
            if digit_sum(out[i]) == digit_sum(out[j]):
                if mapped_indices[i] >= mapped_indices[j]:
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
