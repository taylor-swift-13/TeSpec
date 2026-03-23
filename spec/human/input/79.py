def nat_to_binary_string_aux(n: int, fuel: int) -> str:
    if fuel <= 0:
        return ""
    fuel_prime = fuel - 1
    if n == 0:
        return "0"
    elif n == 1:
        return "1"
    else:
        if n % 2 == 0:
            return nat_to_binary_string_aux(n // 2, fuel_prime) + "0"
        else:
            return nat_to_binary_string_aux((n - 1) // 2, fuel_prime) + "1"

def nat_to_binary_string(n: int) -> str:
    if n < 0:
        n = 0
    if n == 0:
        return "0"
    else:
        return nat_to_binary_string_aux(n, n)

def decimal_to_binary_impl(decimal: int) -> str:
    return "db" + nat_to_binary_string(decimal) + "db"

def problem_79_pre(decimal: int) -> bool:
    return True

def problem_79_spec(decimal: int, output: str) -> bool:
    return output == decimal_to_binary_impl(decimal)
