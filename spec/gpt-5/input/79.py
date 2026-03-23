def char_of_bit(b):
    if b:
        return '1'
    else:
        return '0'

def string_of_bits(bits):
    return "".join(char_of_bit(b) for b in bits)

def bits_value_fold(bits, acc):
    for b in bits:
        val = 1 if b else 0
        acc = 2 * acc + val
    return acc

def bits_value(bits):
    return bits_value_fold(bits, 0)

def _orig_decimal_to_binary_spec(decimal, output):
    if not (output.startswith('db') and output.endswith('db')):
        return False
    if len(output) < 4:
        return False
    inner = output[2:-2]
    bits = []
    for char in inner:
        if char == '1':
            bits.append(True)
        elif char == '0':
            bits.append(False)
        else:
            return False
    if bits_value(bits) != decimal:
        return False
    if decimal == 0:
        return bits == [False]
    elif decimal > 0:
        return len(bits) > 0 and bits[0] == True
    return False

def decimal_to_binary_spec(decimal, output):
    return bool(_orig_decimal_to_binary_spec(decimal, output))
