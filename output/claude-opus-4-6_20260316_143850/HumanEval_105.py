
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    arr = args[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True


def postcondition(input, output):
    arr = input[0]
    valid_names = {"One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"}
    name_map = {1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five",
                6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"}

    if not isinstance(output, list):
        return False

    # Filter to only 1-9
    filtered = [x for x in arr if 1 <= x <= 9]

    # Output length should match number of valid elements
    if len(output) != len(filtered):
        return False

    if len(output) == 0:
        return True

    # All output elements should be valid name strings
    for name in output:
        if name not in valid_names:
            return False

    # Build expected result: sort filtered, reverse, map to names
    expected = [name_map[x] for x in sorted(filtered, reverse=True)]

    if output != expected:
        return False

    return True

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
