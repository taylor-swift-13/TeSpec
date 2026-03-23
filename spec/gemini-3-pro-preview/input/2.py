import math

def _orig_truncate_number_spec(number, output):
    if not number >= 0:
        return True
    i = math.floor(number)
    return output == number - i

def truncate_number_spec(number, output):
    return bool(_orig_truncate_number_spec(number, output))
