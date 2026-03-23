def to_digits_fuel(n, fuel):
    if fuel == 0:
        return []
    res = []
    curr_n = n
    for _ in range(fuel):
        if curr_n < 10:
            res.insert(0, curr_n)
            break
        else:
            res.insert(0, curr_n % 10)
            curr_n //= 10
    return res

def to_digits(n):
    if n == 0:
        return [0]
    else:
        return to_digits_fuel(n, n)

def digit_to_string(d):
    mapping = {
        0: "0", 1: "1", 2: "2", 3: "3", 4: "4",
        5: "5", 6: "6", 7: "7", 8: "8", 9: "9"
    }
    return mapping.get(d, "")

def from_digits_to_string(l):
    return "".join(digit_to_string(d) for d in l)

def circular_shift_impl(x, shift):
    digits = to_digits(x)
    length = len(digits)
    if x == 0:
        return "0"
    else:
        if length < shift:
            return from_digits_to_string(list(reversed(digits)))
        else:
            effective_shift = shift % length
            if effective_shift == 0:
                return from_digits_to_string(digits)
            else:
                split_point = length - effective_shift
                new_head = digits[split_point:]
                new_tail = digits[:split_point]
                return from_digits_to_string(new_head + new_tail)

def _orig_problem_65_pre(x, shift):
    return True

def _orig_problem_65_spec(x, shift, output):
    return output == circular_shift_impl(x, shift)

def problem_65_pre(x, shift):
    return bool(_orig_problem_65_pre(x, shift))

def problem_65_spec(x, shift, output):
    return bool(_orig_problem_65_spec(x, shift, output))
