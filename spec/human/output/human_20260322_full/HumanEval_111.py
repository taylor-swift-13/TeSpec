def filter_spaces(l: list) -> list:
    return [c for c in l if c != ' ']

def count_char(letters: list, c: str) -> int:
    return letters.count(c)

def get_max_count(letters: list) -> int:
    unique_letters = []
    for c in letters:
        if c not in unique_letters:
            unique_letters.append(c)
    if not unique_letters:
        return 0
    counts = [count_char(letters, c) for c in unique_letters]
    counts.append(0)
    return max(counts)

def problem_111_pre(s: str) -> bool:
    for c in s:
        if not (c == ' ' or (97 <= ord(c) <= 122)):
            return False
    return True

def problem_111_spec(s: str, res: list) -> bool:
    raw_letters = list(s)
    letters = filter_spaces(raw_letters)
    
    # Coq's nodup keeps unique elements. The order doesn't affect the logic here.
    unique_letters = []
    for c in letters:
        if c not in unique_letters:
            unique_letters.append(c)
            
    if not unique_letters:
        return res == []
        
    max_count = get_max_count(letters)
    
    # 1. "Soundness": Every element in res must be correct.
    for p in res:
        try:
            c, n = p
        except (ValueError, TypeError):
            return False
        if n != max_count or count_char(letters, c) != max_count:
            return False
            
    # 2. "Completeness": Every valid character must be in res.
    for c in unique_letters:
        if count_char(letters, c) == max_count:
            if (c, max_count) not in res:
                return False
                
    return True

def _impl(test):
    if test == "": return {}
    count, ans = dict(), dict()
    for word in test.split(" "):
        if word != "":
            if word not in count: count[word] = 0
            count[word] += 1
    mx = max(list(count.values()))
    for ch, c in count.items():
        if c == mx:
            ans[ch] = c
    return ans

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_111_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_111_spec(*input, output))

def histogram(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
