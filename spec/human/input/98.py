def is_uppercase_vowel_bool(c):
    return c in ['A', 'E', 'I', 'O', 'U']

def count_upper_impl(s):
    count = 0
    for i in range(len(s)):
        if i % 2 == 0 and is_uppercase_vowel_bool(s[i]):
            count += 1
    return count

def problem_98_pre(s):
    return True

def problem_98_spec(s, output):
    return output == count_upper_impl(s)
