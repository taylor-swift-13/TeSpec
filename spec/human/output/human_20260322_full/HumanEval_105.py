def is_target_digit(z: int) -> bool:
    return 1 <= z <= 9

def digit_to_word(z: int) -> str:
    if z == 1:
        return "One"
    elif z == 2:
        return "Two"
    elif z == 3:
        return "Three"
    elif z == 4:
        return "Four"
    elif z == 5:
        return "Five"
    elif z == 6:
        return "Six"
    elif z == 7:
        return "Seven"
    elif z == 8:
        return "Eight"
    elif z == 9:
        return "Nine"
    else:
        return ""

def problem_105_pre(l_in: list) -> bool:
    return True

def problem_105_spec(l_in: list, l_out: list) -> bool:
    l_filtered = [z for z in l_in if is_target_digit(z)]
    l_sorted = sorted(l_filtered)
    l_reversed = l_sorted[::-1]
    expected_out = [digit_to_word(z) for z in l_reversed]
    return l_out == expected_out

def _impl(arr):
    def to_word(x: int) -> str:
      if x == 1:
        return "One"
      elif x == 2:
        return "Two"
      elif x == 3:
        return "Three"
      elif x == 4:
        return "Four"
      elif x == 5:
        return "Five"
      elif x == 6:
        return "Six"
      elif x == 7:
        return "Seven"
      elif x == 8:
        return "Eight"
      else:
        return "Nine"
    sorted_list, ans = sorted(arr)[::-1], []
    for x in sorted_list:
      if 1 <= x <= 9:
        ans.append(to_word(x))
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_105_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_105_spec(*input, output))

def by_length(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
