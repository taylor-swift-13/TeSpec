from typing import List

def sum_list(l):
    """
    Definition sum_list (l : list Z) : Z :=
      fold_left Z.add l 0%Z.
    """
    return sum(l)

def below_zero_spec(operations, result):
    """
    Definition below_zero_spec (operations : list Z) (result : bool) : Prop :=
      (result = true <-> exists prefix suffix, operations = prefix ++ suffix /\ sum_list prefix < 0%Z) /\
      (result = false <-> forall prefix suffix, operations = prefix ++ suffix -> 0%Z <= sum_list prefix).
    """
    # The specification states that 'result' is true if and only if there exists
    # a prefix of 'operations' such that the sum of the prefix is less than 0.
    
    # We calculate the actual truth value of this condition.
    condition_met = False
    
    # Check the empty prefix first. sum_list([]) is 0.
    # 0 < 0 is False, so the empty prefix does not satisfy the condition.
    current_sum = 0
    
    # Check non-empty prefixes by iterating through the list
    for x in operations:
        current_sum += x
        if current_sum < 0:
            condition_met = True
            break
            
    # The function returns True if the input 'result' matches the calculated condition
    return result == condition_met

def _impl(operations: List[int]) -> bool:
    account = 0
    for operation in operations:
        account += operation
        if account < 0:
            return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(below_zero_spec(*input, output))

def below_zero(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
