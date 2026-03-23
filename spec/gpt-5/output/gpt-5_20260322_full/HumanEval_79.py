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

def decimal_to_binary_spec(decimal, res):
    # Check if res starts and ends with "db"
    if not (res.startswith("db") and res.endswith("db")):
        return False
    
    # Ensure the string is long enough to contain the delimiters (min "dbdb")
    if len(res) < 4:
        return False
        
    # Extract the inner string representing the bits
    inner = res[2:-2]
    
    # Convert the inner string back to a list of booleans
    bits = []
    for char in inner:
        if char == '1':
            bits.append(True)
        elif char == '0':
            bits.append(False)
        else:
            # If there are characters other than '0' or '1', no list of bools matches
            return False
            
    # Check 1: bits_value bits = decimal
    if bits_value(bits) != decimal:
        return False
        
    # Check 2: Canonical representation constraints
    # (decimal = 0 /\ bits = false :: nil) \/ (decimal > 0 /\ exists bs, bits = true :: bs)
    if decimal == 0:
        return bits == [False]
    elif decimal > 0:
        # Must start with True (no leading zeros)
        return len(bits) > 0 and bits[0] == True
    
    # If decimal < 0, it cannot be represented by bits_value (which is always >= 0)
    return False

def _impl(decimal):
    return "db" + bin(decimal)[2:] + "db"

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(decimal_to_binary_spec(*input, output))

def decimal_to_binary(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
