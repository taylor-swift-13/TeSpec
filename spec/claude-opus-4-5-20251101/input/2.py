import math

def _orig_truncate_number_spec(number, output):
    if number <= 0:
        return False
    int_part = math.floor(number)
    expected_result = number - int_part
    return output == expected_result and 0 <= output < 1

def truncate_number_spec(number, output):
    return bool(_orig_truncate_number_spec(number, output))
