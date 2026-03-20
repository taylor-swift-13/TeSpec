def remove_duplicates_spec(numbers, result):
    return result == [x for x in numbers if numbers.count(x) == 1]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(remove_duplicates_spec(*input, output))
