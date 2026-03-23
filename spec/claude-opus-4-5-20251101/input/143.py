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

# def words_in_sentence_spec(sentence, result):
#     words = split_by_space(sentence)
#     
#     if not result:
#         filtered_words = []
#     else:
#         filtered_words = split_by_space(result)
#
#     # Check if result is consistent with join_by_space
#     if join_by_space(filtered_words) != result:
#         return False
#
#     # Condition 1: Membership
#     # forall w, In w filtered_words <-> (In w words /\ is_prime (word_length w))
#     # This checks set equivalence of elements.
#     all_words = set(words) | set(filtered_words)
#     for w in all_words:
#         in_filtered = w in filtered_words
#         in_words = w in words
#         is_p = is_prime(word_length(w))
#         if in_filtered != (in_words and is_p):
#             return False
#
#     # Condition 2: Pairwise order preservation
#     # forall i j w1 w2, i < j -> exists i' j', i' < j' /\ words[i'] = w1 /\ words[j'] = w2
#     
#     # Precompute indices for each word in the original sentence
#     word_indices = {}
#     for idx, w in enumerate(words):
#         if w not in word_indices:
#             word_indices[w] = []
#         word_indices[w].append(idx)
#
#     for i in range(len(filtered_words)):
#         for j in range(i + 1, len(filtered_words)):
#             w1 = filtered_words[i]
#             w2 = filtered_words[j]
#             
#             # We need to find if there exists a pair of indices (idx1, idx2)
#             # such that words[idx1] == w1, words[idx2] == w2, and idx1 < idx2.
#             # This is equivalent to checking if the first occurrence of w1 
#             # is before the last occurrence of w2.
#             
#             # Note: w1 and w2 are guaranteed to be in words by Condition 1 check.
#             first_w1 = word_indices[w1][0]
#             last_w2 = word_indices[w2][-1]
#             
#             if not (first_w1 < last_w2):
#                 return False
#
#     return True

def words_in_sentence_spec(sentence, result):
    words = split_by_space(sentence)
    if not result:
        filtered_words = []
    else:
        filtered_words = split_by_space(result)
    if join_by_space(filtered_words) != result:
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
