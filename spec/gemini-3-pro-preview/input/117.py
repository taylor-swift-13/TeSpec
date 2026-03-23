def is_vowel(c):
    if c in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]:
        return True
    else:
        return False

def count_consonants(s):
    # In the Coq spec, anything that is not a vowel adds 1 to the count.
    # This includes punctuation, numbers, etc., not just consonants.
    count = 0
    for c in s:
        if is_vowel(c):
            count += 0
        else:
            count += 1
    return count

def split_words_aux(s, acc):
    # Implementing the logic of the Coq Fixpoint iteratively for Python execution.
    # The logic accumulates characters into 'acc' until a space is found.
    result = []
    current_acc = acc
    
    for c in s:
        if c == " ":
            if current_acc == "":
                # if string_dec acc "" then split_words_aux s' ""
                pass
            else:
                # acc :: split_words_aux s' ""
                result.append(current_acc)
                current_acc = ""
        else:
            # split_words_aux s' (acc ++ String c EmptyString)
            current_acc += c
            
    # Base case: match s with EmptyString
    if current_acc != "":
        result.append(current_acc)
        
    return result

def get_words(s):
    return split_words_aux(s, "")

def _orig_select_words_spec(s, n, output):
    words = get_words(s)
    filtered_words = [w for w in words if count_consonants(w) == n]
    return output == filtered_words

def select_words_spec(s, n, output):
    return bool(_orig_select_words_spec(s, n, output))
