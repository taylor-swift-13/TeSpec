def remove_duplicates_spec(numbers, result):
    return result == [x for x in numbers if numbers.count(x) == 1]
