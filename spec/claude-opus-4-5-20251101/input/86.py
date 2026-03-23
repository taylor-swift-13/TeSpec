from collections import Counter

def char_to_nat(c):
    return ord(c)

def sorted_by_ascii(l):
    def insert(c, sorted_list):
        if not sorted_list:
            return [c]
        h = sorted_list[0]
        t = sorted_list[1:]
        if char_to_nat(c) <= char_to_nat(h):
            return [c] + sorted_list
        else:
            return [h] + insert(c, t)
    
    res = []
    for c in reversed(l):
        res = insert(c, res)
    return res

def is_sorted_by_ascii(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if char_to_nat(l[i]) > char_to_nat(l[j]):
                return False
    return True

def is_permutation(l1, l2):
    return Counter(l1) == Counter(l2)

def string_to_list(s):
    return list(s)

def list_to_string(l):
    return "".join(l)

def split_by_space(s):
    if s == "":
        return [""]
    c = s[0]
    rest = s[1:]
    if char_to_nat(c) == 32:
        return [""] + split_by_space(rest)
    else:
        rest_split = split_by_space(rest)
        if not rest_split:
            return [c]
        else:
            h = rest_split[0]
            t = rest_split[1:]
            return [c + h] + t

def join_with_space(words):
    if not words:
        return ""
    if len(words) == 1:
        return words[0]
    w = words[0]
    rest = words[1:]
    return w + " " + join_with_space(rest)

def sort_word(w):
    return list_to_string(sorted_by_ascii(string_to_list(w)))

def _orig_anti_shuffle_spec(s, output):
    input_words = split_by_space(s)
    output_words = split_by_space(output)
    if len(input_words) != len(output_words):
        return False
    for i in range(len(input_words)):
        in_word = input_words[i]
        out_word = output_words[i]
        if not is_permutation(string_to_list(in_word), string_to_list(out_word)):
            return False
        if not is_sorted_by_ascii(string_to_list(out_word)):
            return False
    expected = join_with_space([sort_word(w) for w in input_words])
    return output == expected

def anti_shuffle_spec(s, output):
    return bool(_orig_anti_shuffle_spec(s, output))
