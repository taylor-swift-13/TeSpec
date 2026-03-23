def WordToNum(s: str) -> int:
    mapping = {
        "zero": 0,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }
    return mapping.get(s, -1)

def is_valid_word(s: str) -> bool:
    return WordToNum(s) != -1

def IsSorted(l: list) -> bool:
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            n_i = WordToNum(l[i])
            n_j = WordToNum(l[j])
            if n_i > n_j:
                return False
    return True

def SplitOnSpaces_aux(current_group: list, S: str) -> list:
    res = []
    curr = list(current_group)
    for char in S:
        if char == ' ':
            if curr:
                res.append("".join(reversed(curr)))
                curr = []
        else:
            curr.insert(0, char)
    if curr:
        res.append("".join(reversed(curr)))
    return res

def SplitOnSpaces(S: str) -> list:
    return SplitOnSpaces_aux([], S)

def _orig_problem_19_pre(input: str) -> bool:
    return True

def _orig_problem_19_spec(input: str, output: str) -> bool:
    input_list = SplitOnSpaces(input)
    output_list = SplitOnSpaces(output)
    if not all((is_valid_word(w) for w in input_list)):
        return False
    if sorted(input_list) != sorted(output_list):
        return False
    if not IsSorted(output_list):
        return False
    return True

def problem_19_pre(numbers):
    return bool(_orig_problem_19_pre(numbers))

def problem_19_spec(numbers, output):
    return bool(_orig_problem_19_spec(numbers, output))
