def is_digit(x):
    return 1 <= x <= 9

def to_word(x):
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

def by_length_spec(arr, ans):
    digits = [x for x in arr if is_digit(x)]
    digits_desc = sorted(digits, reverse=True)
    expected_ans = [to_word(x) for x in digits_desc]
    return ans == expected_ans

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
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(by_length_spec(*input, output))

def by_length(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
