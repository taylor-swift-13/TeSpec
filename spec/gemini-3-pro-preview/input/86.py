def list_of_string(s: str) -> list:
    return list(s)

def ascii_le(c1: str, c2: str) -> bool:
    return ord(c1) <= ord(c2)

def is_sorted_string(s: str) -> bool:
    lst = list_of_string(s)
    for i in range(len(lst) - 1):
        if ord(lst[i]) > ord(lst[i+1]):
            return False
    return True

def is_permutation_string(s1: str, s2: str) -> bool:
    return sorted(list(s1)) == sorted(list(s2))

def word_has_no_space(s: str) -> bool:
    return " " not in s

def join_space(l: list) -> str:
    if not l:
        return ""
    if len(l) == 1:
        return l[0]
    res = l[0]
    for i in range(1, len(l)):
        res += " " + l[i]
    return res

def word_transform(input_word: str, output_word: str) -> bool:
    return is_permutation_string(input_word, output_word) and is_sorted_string(output_word)

def anti_shuffle_spec(s: str, result: str) -> bool:
    # The join_space function in Coq implies that words are separated by exactly one space.
    # If s is empty, words must be [].
    # If s is not empty, words must be s.split(" ").
    
    if s == "":
        words = []
    else:
        words = s.split(" ")
        
    if result == "":
        ordered_words = []
    else:
        ordered_words = result.split(" ")
        
    # Verify s = join_space words
    if join_space(words) != s:
        return False
        
    # Verify result = join_space ordered_words
    if join_space(ordered_words) != result:
        return False
        
    # Verify Forall word_has_no_space words
    if not all(word_has_no_space(w) for w in words):
        return False
        
    # Verify Forall2 word_transform words ordered_words
    if len(words) != len(ordered_words):
        return False
        
    for w1, w2 in zip(words, ordered_words):
        if not word_transform(w1, w2):
            return False
            
    return True
