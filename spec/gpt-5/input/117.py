def is_vowel(ch: str) -> bool:
    return ch in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

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
    res = []
    for ch in s:
        if ch == space_char:
            if acc_rev != "":
                res.append(rev_string(acc_rev))
                acc_rev = ""
        else:
            acc_rev = ch + acc_rev
    if acc_rev != "":
        res.append(rev_string(acc_rev))
    return res

def split_spaces_nonempty(s: str) -> list:
    return split_spaces_nonempty_acc(s, "")

def select_words_spec(s: str, n: int, ans: list) -> bool:
    expected = [w for w in split_spaces_nonempty(s) if count_consonants(w) == n]
    return ans == expected
