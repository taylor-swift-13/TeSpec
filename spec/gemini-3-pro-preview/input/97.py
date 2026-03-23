def multiply_spec(a: int, b: int, result: int) -> bool:
    return result == (abs(a) % 10) * (abs(b) % 10)
