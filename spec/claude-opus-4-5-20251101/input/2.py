import math

def truncate_number_spec(number, result):
    if number <= 0:
        return False
    int_part = math.floor(number)
    expected_result = number - int_part
    return result == expected_result and 0 <= result < 1
