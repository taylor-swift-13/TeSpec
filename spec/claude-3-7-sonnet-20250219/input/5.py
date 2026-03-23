def _orig_intersperse_spec(numbers, delimeter, output):
    expected = []
    if numbers:
        expected.append(numbers[0])
        for num in numbers[1:]:
            expected.append(delimeter)
            expected.append(num)
    return output == expected

def intersperse_spec(numbers, delimeter, output):
    return bool(_orig_intersperse_spec(numbers, delimeter, output))
