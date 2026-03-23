def remove_duplicates_spec(numbers, result):
    expected = [x for x in numbers if numbers.count(x) == 1]
    return result == expected
