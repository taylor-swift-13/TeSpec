import math

def truncate_number_spec(number, result):
    if not (number >= 0):
        return True
    
    # exists i : Z, IZR i <= number < IZR i + 1
    # This uniquely defines i as the floor of number.
    i = math.floor(number)
    
    # result = number - IZR i
    return result == number - i
