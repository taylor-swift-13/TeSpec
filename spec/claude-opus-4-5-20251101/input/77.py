def iscube_spec(a: int, result: bool) -> bool:
    abs_a = abs(a)
    low = 0
    high = abs_a
    is_c = False
    while low <= high:
        mid = (low + high) // 2
        mid3 = mid * mid * mid
        if mid3 == abs_a:
            is_c = True
            break
        elif mid3 < abs_a:
            low = mid + 1
        else:
            high = mid - 1
    return is_c == result
