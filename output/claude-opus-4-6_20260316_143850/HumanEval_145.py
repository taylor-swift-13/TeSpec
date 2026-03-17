
def precondition(input):
    nums = input[0]
    if not isinstance(nums, list):
        return False
    for n in nums:
        if not isinstance(n, int):
            return False
    return True


def postcondition(input, output):
    nums = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    # output must be a permutation of input
    if sorted(output) != sorted(nums):
        return False

    # Helper to compute digit sum
    def digit_sum(n):
        return sum(int(d) for d in str(abs(n)))

    # Check that output is sorted by digit sum (stable)
    for i in range(len(output) - 1):
        if digit_sum(output[i]) > digit_sum(output[i + 1]):
            return False

    # Check stability: elements with same digit sum should appear in original order
    # Group output indices by digit sum
    from collections import defaultdict
    groups = defaultdict(list)
    for val in output:
        groups[digit_sum(val)].append(val)

    for ds, group in groups.items():
        # Find original indices for these values
        # We need to match them carefully (there could be duplicates)
        original_indices = []
        used = set()
        for val in group:
            for idx in range(len(nums)):
                if idx not in used and nums[idx] == val:
                    original_indices.append(idx)
                    used.add(idx)
                    break
        # original_indices should be in ascending order (stable sort)
        if original_indices != sorted(original_indices):
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
