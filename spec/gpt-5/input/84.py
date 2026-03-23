def value_base_acc(base, acc, ds):
    for d in ds:
        acc = base * acc + d
    return acc

def value_base_Z(base, ds):
    return value_base_acc(base, 0, ds)

def sum_list_Z(ds):
    return sum(ds)

def decimal_digits_of(N, ds):
    if not all(0 <= d <= 9 for d in ds):
        return False
    if value_base_Z(10, ds) != N:
        return False
    if N == 0:
        return ds == [0]
    else:
        return len(ds) > 0 and ds[0] != 0

def bit_to_Z(b):
    return 1 if b else 0

def string_of_bits(bs):
    return "".join("1" if b else "0" for b in bs)

def value_bits(bits):
    return value_base_acc(2, 0, [bit_to_Z(b) for b in bits])

def binary_string_of(s, out):
    if s < 0:
        return False
    if s == 0:
        return out == "0"
    return out == bin(s)[2:]

def solve_spec(N, out):
    if not (0 <= N <= 10000):
        return False
    
    if N == 0:
        ds = [0]
    else:
        ds = [int(c) for c in str(N)]
        
    s = sum_list_Z(ds)
    return binary_string_of(s, out)
