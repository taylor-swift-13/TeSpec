space_char = ' '

def nospace(s: str) -> bool:
    return ' ' not in s

def join_space(l: list) -> str:
    if not l:
        return ""
    return " ".join(l)

def occ(x: str, l: list) -> int:
    return l.count(x)

def histogram_spec(test: str, ans: list) -> bool:
    if test == "" and ans == []:
        return True
    if test == "":
        return False
    
    # Since join_space joins with a single space, splitting by ' ' 
    # uniquely recovers the tokens list.
    tokens = test.split(' ')
    
    non_empty_tokens = [t for t in tokens if t != ""]
    if not non_empty_tokens:
        return False
        
    counts = {}
    for t in tokens:
        counts[t] = counts.get(t, 0) + 1
        
    m = max(counts[t] for t in non_empty_tokens)
    
    # Check NoDup (map fst ans)
    ans_keys = [k for k, v in ans]
    if len(ans_keys) != len(set(ans_keys)):
        return False
        
    # Check that every element in ans is valid and has max occurrences
    for s, n in ans:
        if n != m:
            return False
        if s == "":
            return False
        if counts.get(s, 0) != m:
            return False
            
    # Check that every non-empty token with max occurrences is in ans
    for s in non_empty_tokens:
        if counts[s] == m:
            if (s, m) not in ans:
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
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(histogram_spec(*input, output))

def histogram(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
