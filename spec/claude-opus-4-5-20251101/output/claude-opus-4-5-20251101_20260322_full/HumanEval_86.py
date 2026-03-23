def char_to_nat(c: str) -> int:
    return ord(c)

def sorted_by_ascii(l: list) -> list:
    return sorted(l, key=char_to_nat)

def is_sorted_by_ascii(l: list) -> bool:
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if char_to_nat(l[i]) > char_to_nat(l[j]):
                return False
    return True

def is_permutation(l1: list, l2: list) -> bool:
    if len(l1) != len(l2):
        return False
    return sorted(l1) == sorted(l2)

def string_to_list(s: str) -> list:
    return list(s)

def list_to_string(l: list) -> str:
    return "".join(l)

def split_by_space(s: str) -> list:
    if s == "":
        return [""]
    return s.split(' ')

def join_with_space(words: list) -> str:
    return " ".join(words)

def sort_word(w: str) -> str:
    return list_to_string(sorted_by_ascii(string_to_list(w)))

def anti_shuffle_spec(s: str, result: str) -> bool:
    input_words = split_by_space(s)
    output_words = split_by_space(result)
    
    if len(input_words) != len(output_words):
        return False
        
    for i in range(len(input_words)):
        in_word = input_words[i]
        out_word = output_words[i]
        
        if not is_permutation(string_to_list(in_word), string_to_list(out_word)):
            return False
        if not is_sorted_by_ascii(string_to_list(out_word)):
            return False
            
    expected_result = join_with_space([sort_word(w) for w in input_words])
    return result == expected_result

def _impl(s):
    words = s.split(" ")
    return " ".join(map(lambda x: "".join(sorted(x, key=lambda ch: ord(ch))), words))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(anti_shuffle_spec(*input, output))

def anti_shuffle(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
