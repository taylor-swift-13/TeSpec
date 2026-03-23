def choose_num_spec(x: int, y: int, r: int) -> bool:
    if x > y:
        return r == -1
    else:
        max_even = y if y % 2 == 0 else y - 1
        if max_even >= x:
            return r == max_even
        else:
            return r == -1
