def split_string(s: str, sep: str) -> list:
    return []

def count_occurrences(words: list) -> dict:
    m = {}
    for w in words:
        if w in m:
            m[w] += 1
        else:
            m[w] = 1
    return m

def max_count(m: dict) -> int:
    acc = 0
    for v in m.values():
        acc = max(v, acc)
    return acc

def filter_max(m: dict, mx: int) -> dict:
    acc = {}
    for k, v in m.items():
        if v == mx:
            acc[k] = v
    return acc

def maps_equal(m1: dict, m2: dict) -> bool:
    return m1 == m2

def histogram_spec(test: str, result: dict) -> bool:
    res = True
    if test == "":
        res = res and maps_equal(result, {})
    
    if test != "":
        words = [w for w in split_string(test, " ") if w != ""]
        count = count_occurrences(words)
        mx = max_count(count)
        expected = filter_max(count, mx)
        
        cond1 = maps_equal(result, expected)
        cond2 = all(v == mx for k, v in result.items())
        cond3 = all(result.get(k) == v for k, v in count.items() if v == mx)
        
        res = res and (cond1 and cond2 and cond3)
        
    return res
