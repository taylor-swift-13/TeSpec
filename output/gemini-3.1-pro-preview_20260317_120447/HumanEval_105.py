
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    arr = inp[0]
    return isinstance(arr, list) and all(isinstance(x, int) for x in arr)

def postcondition(inp, out):
    if not precondition(inp):
        return False
    arr = inp[0]
    if not isinstance(out, list):
        return False
    names = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
    if not all(isinstance(x, str) and x in names for x in out):
        return False
    valid_ints = [x for x in arr if 1 <= x <= 9]
    name_to_val = {name: i + 1 for i, name in enumerate(names)}
    out_vals = [name_to_val[x] for x in out]
    return out_vals == sorted(valid_ints, reverse=True)

def _impl(arr):
    """Given an array of integers, sort the integers that are between 1 and 9 inclusive,
    reverse the resulting array, and then replace each digit by its corresponding name from
    "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine".

    For example:
      arr = [2, 1, 1, 4, 5, 8, 2, 3]   
            -> sort arr -> [1, 1, 2, 2, 3, 4, 5, 8] 
            -> reverse arr -> [8, 5, 4, 3, 2, 2, 1, 1]
      return ["Eight", "Five", "Four", "Three", "Two", "Two", "One", "One"]

      If the array is empty, return an empty array:
      arr = []
      return []

      If the array has any strange number ignore it:
      arr = [1, -1 , 55] 
            -> sort arr -> [-1, 1, 55]
            -> reverse arr -> [55, 1, -1]
      return = ['One']"""
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

def by_length(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
