from typing import List, Any

def precondition(input_args: tuple) -> bool:
    return (
        isinstance(input_args, tuple) and 
        len(input_args) == 1 and 
        isinstance(input_args[0], list)
    )

def postcondition(input_args: tuple, output: any) -> bool:
    if not isinstance(output, list):
        return False
    values = input_args[0]
    # In Python, bool is a subclass of int, but typically "integers" 
    # in this context refers to the int type specifically.
    expected = [x for x in values if type(x) is int]
    return output == expected

def _impl(values: List[Any]) -> List[int]:
    """Filter given list of any python values only for integers
    [5]
    [1, 2, 3]"""
    return list(filter(lambda x: type(x) == int, values))

def filter_integers(values: List[Any]) -> List[int]:
    _input = (values,)
    assert precondition(_input)
    _output = _impl(values)
    assert postcondition(_input, _output)
    return _output
