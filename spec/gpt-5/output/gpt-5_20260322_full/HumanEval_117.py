def is_vowel(ch: str) -> bool:
    return ch in "aeiouAEIOU"

def rev_string(s: str) -> str:
    return s[::-1]

def count_consonants(w: str) -> int:
    cnt = 0
    for ch in w:
        if not is_vowel(ch):
            cnt += 1
    return cnt

space_char = " "

def split_spaces_nonempty_acc(s: str, acc_rev: str) -> list:
    if s == "":
        if acc_rev == "":
            return []
        else:
            return [rev_string(acc_rev)]
    
    ch = s[0]
    rest = s[1:]
    
    if ch == space_char:
        if acc_rev == "":
            return split_spaces_nonempty_acc(rest, "")
        else:
            return [rev_string(acc_rev)] + split_spaces_nonempty_acc(rest, "")
    else:
        return split_spaces_nonempty_acc(rest, ch + acc_rev)

def split_spaces_nonempty(s: str) -> list:
    return split_spaces_nonempty_acc(s, "")

def select_words_spec(s: str, n: int, ans: list) -> bool:
    expected = [w for w in split_spaces_nonempty(s) if count_consonants(w) == n]
    return ans == expected

def _impl(s, n):
    ans = []
    for word in s.split(" "):
        if word != "":
            c_cnt = len(list(filter(lambda ch: ch not in "aeiouAEIOU", word)))
            if c_cnt == n: ans.append(word)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(select_words_spec(*input, output))

def select_words(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
