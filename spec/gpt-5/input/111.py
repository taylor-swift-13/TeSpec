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

    # Verify Forall nospace tokens
    if any(not nospace(t) for t in tokens):
        return False

    # Verify test = join_space tokens
    if join_space(tokens) != test:
        return False

    # The Coq spec requires the existence of a non-empty string s0 in tokens
    non_empty_tokens = [t for t in tokens if t != ""]
    if not non_empty_tokens:
        return False

    # m is the maximum occurrence count among non-empty tokens.
    # We count occurrences in the full tokens list to exactly match Coq's occ behavior.
    m = max(occ(t, tokens) for t in non_empty_tokens)

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
        if occ(s, tokens) != m:
            return False

    # Check that every non-empty token with max occurrences is in ans
    for s in set(non_empty_tokens):
        if occ(s, tokens) == m:
            if not any(k == s and v == m for k, v in ans):
                return False

    return True
