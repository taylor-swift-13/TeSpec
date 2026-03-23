def char_to_digit(c):
    val = ord(c) - 48
    return val if val >= 0 else 0

def string_to_nat_aux(s, acc):
    for c in s:
        acc = acc * 10 + char_to_digit(c)
    return acc

def string_to_nat(s):
    return string_to_nat_aux(s, 0)

def parse_fruit_string(s, apples, oranges):
    sep = " apples and "
    suffix = " oranges"
    
    if not s.endswith(suffix):
        return False
        
    rem = s[:-len(suffix)]
    start = 0
    
    while True:
        idx = rem.find(sep, start)
        if idx == -1:
            break
            
        s_apples = rem[:idx]
        s_oranges = rem[idx + len(sep):]
        
        if string_to_nat(s_apples) == apples and string_to_nat(s_oranges) == oranges:
            return True
            
        start = idx + 1
        
    return False

def problem_67_pre(s, n):
    return True

def problem_67_spec(s, n, ret):
    sep = " apples and "
    suffix = " oranges"
    
    if not s.endswith(suffix):
        return False
        
    rem = s[:-len(suffix)]
    start = 0
    
    while True:
        idx = rem.find(sep, start)
        if idx == -1:
            break
            
        s_apples = rem[:idx]
        s_oranges = rem[idx + len(sep):]
        
        apples = string_to_nat(s_apples)
        oranges = string_to_nat(s_oranges)
        
        total_fruits = apples + oranges
        expected = n - total_fruits if n >= total_fruits else 0
        
        if ret == expected:
            return True
            
        start = idx + 1
        
    return False
