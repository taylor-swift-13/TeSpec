def _orig_remove_duplicates_spec(numbers, output):
    expected = [x for x in numbers if numbers.count(x) == 1]
    return output == expected

def remove_duplicates_spec(numbers, output):
    return bool(_orig_remove_duplicates_spec(numbers, output))
