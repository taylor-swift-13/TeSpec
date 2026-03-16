
def precondition(input):
    lst = input[0]
    if not isinstance(lst, list):
        return False
    if not all(isinstance(s, str) for s in lst):
        return False
    return True

def postcondition(input, output):
    lst = input[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(s, str) for s in output):
        return False
    if any(len(s) % 2 == 1 for s in output):
        return False
    for i in range(len(output) - 1):
        if len(output[i]) > len(output[i + 1]):
            return False
        if len(output[i]) == len(output[i + 1]) and output[i] > output[i + 1]:
            return False
    return True

def _impl(lst):
    """Write a function that accepts a list of strings as a parameter,
    deletes the strings that have odd lengths from it,
    and returns the resulted list with a sorted order,
    The list is always a list of strings and never an array of numbers,
    and it may contain duplicates.
    The order of the list should be ascending by length of each word, and you
    should return the list sorted by that rule.
    If two words have the same length, sort the list alphabetically.
    The function should return a list of strings in sorted order.
    You may assume that all words will have the same length.
    For example:
    assert list_sort(["aa", "a", "aaa"]) => ["aa"]
    assert list_sort(["ab", "a", "aaa", "cd"]) => ["ab", "cd"]"""
    from functools import cmp_to_key
    def cmp(s: str, t: str):
        if len(s) != len(t):
            return len(s) - len(t)
        return -1 if s < t else 1
    return sorted(list(filter(lambda s: len(s) % 2 == 0, lst)), key=cmp_to_key(cmp))

def sorted_list_sum(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
