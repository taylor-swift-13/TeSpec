def problem_80_pre(s: str) -> bool:
    return True

def problem_80_spec(s: str, output: bool) -> bool:
    if len(s) < 3:
        is_happy = False
    else:
        is_happy = True
        for i in range(len(s) - 2):
            c1 = s[i]
            c2 = s[i + 1]
            c3 = s[i + 2]
            if c1 == c2 or c1 == c3 or c2 == c3:
                is_happy = False
                break
                
    return is_happy == output
