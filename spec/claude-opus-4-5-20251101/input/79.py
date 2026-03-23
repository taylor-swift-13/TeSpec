def Z_to_binary_aux(n, fuel):
    res = ""
    while fuel > 0:
        if n == 0:
            break
        bit = "0" if n % 2 == 0 else "1"
        res = bit + res
        n = n // 2
        fuel -= 1
    return res

def Z_to_binary(n):
    if n == 0:
        return "0"
    fuel = max(0, int(n)) + 1
    return Z_to_binary_aux(n, fuel)

def _orig_decimal_to_binary_spec(decimal, output):
    if decimal < 0:
        return False
    expected = 'db' + Z_to_binary(decimal) + 'db'
    return output == expected

def decimal_to_binary_spec(decimal, output):
    return bool(_orig_decimal_to_binary_spec(decimal, output))
