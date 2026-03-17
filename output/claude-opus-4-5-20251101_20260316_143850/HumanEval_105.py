
def precondition(args):
    arr = args[0]
    # arr must be a list
    if not isinstance(arr, list):
        return False
    # all elements must be integers
    for x in arr:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(args, output):
    arr = args[0]
    valid_names = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"]
    name_to_digit = {"One": 1, "Two": 2, "Three": 3, "Four": 4, "Five": 5, 
                     "Six": 6, "Seven": 7, "Eight": 8, "Nine": 9}
    
    # output must be a list
    if not isinstance(output, list):
        return False
    
    # all elements in output must be valid digit names
    for name in output:
        if name not in valid_names:
            return False
    
    # filter input to only include integers between 1 and 9 inclusive
    filtered = [x for x in arr if isinstance(x, int) and 1 <= x <= 9]
    
    # output length must match filtered input length
    if len(output) != len(filtered):
        return False
    
    # convert output names back to digits
    output_digits = [name_to_digit[name] for name in output]
    
    # output_digits should be the sorted filtered list in reverse order
    expected = sorted(filtered, reverse=True)
    if output_digits != expected:
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
