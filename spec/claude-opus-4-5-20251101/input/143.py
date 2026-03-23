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

def _orig_words_in_sentence_spec(sentence, output):
    words = split_by_space(sentence)
    if not output:
        filtered_words = []
    else:
        filtered_words = split_by_space(output)
    if join_by_space(filtered_words) != output:
        return False
    for w in set(words + filtered_words):
        in_filtered = w in filtered_words
        in_words = w in words
        is_p = is_prime(word_length(w))
        if in_filtered != (in_words and is_p):
            return False
    for i in range(len(filtered_words)):
        for j in range(i + 1, len(filtered_words)):
            w1 = filtered_words[i]
            w2 = filtered_words[j]
            found = False
            for i_prime in range(len(words)):
                if words[i_prime] == w1:
                    for j_prime in range(i_prime + 1, len(words)):
                        if words[j_prime] == w2:
                            found = True
                            break
                if found:
                    break
            if not found:
                return False
    return True

def words_in_sentence_spec(sentence, output):
    return bool(_orig_words_in_sentence_spec(sentence, output))
