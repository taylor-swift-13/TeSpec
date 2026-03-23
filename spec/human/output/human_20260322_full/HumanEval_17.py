from typing import List

def SplitOnSpaces_aux(current_group, S):
    res = []
    # In Coq, current_group stores characters in reverse order.
    # We reverse it here to build the string in the correct order.
    curr = list(reversed(current_group))
    for h in S:
        if h == ' ':
            if curr:
                res.append("".join(curr))
                curr = []
        else:
            curr.append(h)
    if curr:
        res.append("".join(curr))
    return res

def SplitOnSpaces(S):
    return SplitOnSpaces_aux([], S)

def parse_note(note):
    if note == "o":
        return 4
    elif note == "o|":
        return 2
    elif note == ".|":
        return 1
    else:
        return None

def parse_music_impl_aux(notes):
    res = []
    for note in notes:
        n = parse_note(note)
        if n is not None:
            res.append(n)
    return res

def parse_music_impl(input_str):
    return parse_music_impl_aux(SplitOnSpaces(input_str))

def problem_17_pre(input_str):
    return True

def problem_17_spec(input_str, output):
    return output == parse_music_impl(input_str)

def _impl(music_string: str) -> List[int]:
    def count_beats(note: str) -> int:
        if note == "o": return 4
        elif note == "o|": return 2
        elif note == ".|": return 1
    if music_string == "": return []
    return list(map(count_beats, music_string.split(" ")))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_17_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_17_spec(*input, output))

def parse_music(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
