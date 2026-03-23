def count_beats_spec(note: str, b: int) -> bool:
    """
    Checks if a note matches a specific beat count according to the spec:
    - "o"  -> 4 beats
    - "o|" -> 2 beats
    - ".|" -> 1 beat
    """
    if note == "o" and b == 4:
        return True
    if note == "o|" and b == 2:
        return True
    if note == ".|" and b == 1:
        return True
    return False

def join_spaces(tokens: list) -> str:
    """
    Joins a list of strings with a single space between them.
    Matches the Coq Fixpoint logic.
    """
    if not tokens:
        return ""
    if len(tokens) == 1:
        return tokens[0]
    
    # Recursive-like join: x :: xs => x ++ " " ++ join_spaces xs
    return tokens[0] + " " + join_spaces(tokens[1:])

def _orig_parse_music_spec(music_string: str, beats: list) -> bool:
    """
    Checks if there exists a list of tokens that, when joined by spaces,
    matches music_string and satisfies count_beats_spec for each beat in the list.
    
    Since count_beats_spec defines a functional relation from beats to notes (each beat count
    corresponds to exactly one note string), we can construct the expected tokens from the beats
    and check if they join to form the music_string. This avoids ambiguity in parsing.
    """
    expected_tokens = []
    for b in beats:
        if b == 4:
            expected_tokens.append('o')
        elif b == 2:
            expected_tokens.append('o|')
        elif b == 1:
            expected_tokens.append('.|')
        else:
            return False
    return join_spaces(expected_tokens) == music_string

def parse_music_spec(music_string, output):
    return bool(_orig_parse_music_spec(music_string, output))
