def is_prime(n):
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def split_by_space(s):
    if not s:
        return []
    return s.split(' ')

def join_by_space(words):
    return ' '.join(words)

def word_length(w):
    return len(w)

# 旧版本把 witness 条件写得过宽。
# def _orig_words_in_sentence_spec(sentence, output):
#     ...

def _orig_words_in_sentence_spec(sentence, output):
    words = split_by_space(sentence)
    expected = [w for w in words if is_prime(word_length(w))]
    return output == join_by_space(expected)

def words_in_sentence_spec(sentence, output):
    return bool(_orig_words_in_sentence_spec(sentence, output))
