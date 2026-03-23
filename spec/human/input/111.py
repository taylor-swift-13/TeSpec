def filter_spaces(l: list) -> list:
    return [c for c in l if c != ' ']

def count_char(letters: list, c: str) -> int:
    return letters.count(c)

def get_max_count(letters: list) -> int:
    unique_letters = []
    for c in letters:
        if c not in unique_letters:
            unique_letters.append(c)
    if not unique_letters:
        return 0
    counts = [count_char(letters, c) for c in unique_letters]
    counts.append(0)
    return max(counts)

def _orig_problem_111_pre(s: str) -> bool:
    for c in s:
        if not (c == ' ' or 97 <= ord(c) <= 122):
            return False
    return True

def _orig_problem_111_spec(s: str, output: list) -> bool:
    raw_letters = list(s)
    letters = filter_spaces(raw_letters)
    unique_letters = []
    for c in letters:
        if c not in unique_letters:
            unique_letters.append(c)
    if not unique_letters:
        return output == []
    max_count = get_max_count(letters)
    for p in output:
        try:
            (c, n) = p
        except (ValueError, TypeError):
            return False
        if n != max_count or count_char(letters, c) != max_count:
            return False
    for c in unique_letters:
        if count_char(letters, c) == max_count:
            if (c, max_count) not in output:
                return False
    return True

def problem_111_pre(test):
    return bool(_orig_problem_111_pre(test))

def problem_111_spec(test, output):
    return bool(_orig_problem_111_spec(test, output))
