def list_ascii_of_string(s: str) -> list:
    return list(s)

def string_of_list_ascii(l: list) -> str:
    return "".join(l)

def is_uppercase(c: str) -> bool:
    return 'A' <= c <= 'Z'

def is_lowercase(c: str) -> bool:
    return 'a' <= c <= 'z'

def count_pred(p, s: list) -> int:
    return sum(1 for c in s if p(c))

def strength(s: str) -> int:
    l = list_ascii_of_string(s)
    return count_pred(is_uppercase, l) - count_pred(is_lowercase, l)

def is_strongest(best: str, exts: list) -> bool:
    if best not in exts:
        return False
    
    # Find the first occurrence of 'best'
    idx = exts.index(best)
    prefix = exts[:idx]
    post = exts[idx+1:]
    
    best_strength = strength(best)
    
    # 'best' must be strictly stronger than all elements before it
    for e in prefix:
        if strength(e) >= best_strength:
            return False
            
    # 'best' must be stronger than or equal to all elements after it
    for e in post:
        if strength(e) > best_strength:
            return False
            
    return True

def _orig_problem_153_pre(class_name: str, extensions: list) -> bool:
    return len(extensions) > 0

def _orig_problem_153_spec(class_name: str, extensions: list, output: str) -> bool:
    if not extensions:
        return False
    for ext in extensions:
        if is_strongest(ext, extensions):
            if output == class_name + '.' + ext:
                return True
    return False

def problem_153_pre(class_name, extensions):
    return bool(_orig_problem_153_pre(class_name, extensions))

def problem_153_spec(class_name, extensions, output):
    return bool(_orig_problem_153_spec(class_name, extensions, output))
