
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    arr = input[0]
    names = {
        1: "One",
        2: "Two",
        3: "Three",
        4: "Four",
        5: "Five",
        6: "Six",
        7: "Seven",
        8: "Eight",
        9: "Nine",
    }
    filtered = [x for x in arr if 1 <= x <= 9]
    target = sorted(filtered)[::-1]
    target_names = [names[v] for v in target]
    if isinstance(output, (str, bytes)):
        return False
    try:
        out_list = list(output)
    except Exception:
        return False
    if any(not isinstance(s, str) for s in out_list):
        return False
    if any(s not in names.values() for s in out_list):
        return False
    return out_list == target_names

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
