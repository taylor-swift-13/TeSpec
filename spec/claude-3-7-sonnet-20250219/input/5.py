def intersperse_spec(numbers, delimeter, res):
    expected = []
    if numbers:
        expected.append(numbers[0])
        for num in numbers[1:]:
            expected.append(delimeter)
            expected.append(num)
    return res == expected
