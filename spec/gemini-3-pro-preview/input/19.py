def to_int(s: str) -> int:
    if s == "zero":
        return 0
    elif s == "one":
        return 1
    elif s == "two":
        return 2
    elif s == "three":
        return 3
    elif s == "four":
        return 4
    elif s == "five":
        return 5
    elif s == "six":
        return 6
    elif s == "seven":
        return 7
    elif s == "eight":
        return 8
    elif s == "nine":
        return 9
    else:
        return 0

def str_le(s1: str, s2: str) -> bool:
    return to_int(s1) <= to_int(s2)

def is_space(c: str) -> bool:
    return c == " "

def split_by_space(s: str, acc: str) -> list:
    res = []
    for c in s:
        if is_space(c):
            if acc == "":
                continue
            else:
                res.append(acc)
                acc = ""
        else:
            acc += c
    if acc != "":
        res.append(acc)
    return res

def tokenize(s: str) -> list:
    return split_by_space(s, "")

def join_with_space(l: list) -> str:
    if not l:
        return ""
    if len(l) == 1:
        return l[0]
    return l[0] + " " + join_with_space(l[1:])

def sort_numbers_spec(numbers: str, result: str) -> bool:
    if numbers == "":
        return result == ""
    
    input_tokens = tokenize(numbers)
    result_tokens = tokenize(result)
    
    # The result tokens must be a permutation of input tokens
    if sorted(input_tokens) != sorted(result_tokens):
        return False
        
    # The result tokens must be sorted according to their numeric value
    for i in range(len(result_tokens) - 1):
        if not str_le(result_tokens[i], result_tokens[i+1]):
            return False
            
    # The result string must be the joined representation of the sorted tokens
    if result != join_with_space(result_tokens):
        return False
        
    return True
