def digits_of_Z_aux(fuel, n):
    if fuel <= 0:
        return []
    
    digits = []
    curr = n
    count = fuel
    
    # Iterative implementation of the recursive logic
    # Coq: if n < 10 then [n] else digits_of_Z_aux (fuel-1) (n/10) ++ [n mod 10]
    # This builds the list from MSB to LSB.
    # We build LSB to MSB in the loop and reverse at the end.
    while count > 0:
        if curr < 10:
            digits.append(curr)
            break
        digits.append(curr % 10)
        curr //= 10
        count -= 1
        
    return digits[::-1]

def digits_of_Z(n):
    if n == 0:
        return [0]
    # Z.to_nat n is n for n >= 0, else 0
    fuel = n if n > 0 else 0
    return digits_of_Z_aux(fuel, n)

def signed_digits_sum(n):
    abs_n = abs(n)
    digits = digits_of_Z(abs_n)
    if not digits:
        return 0
    hd = digits[0]
    tl = digits[1:]
    sum_rest = sum(tl)
    if n < 0:
        return -hd + sum_rest
    else:
        return hd + sum_rest

def count_nums_spec(arr, res):
    count = 0
    for x in arr:
        if signed_digits_sum(x) > 0:
            count += 1
    return res == count
