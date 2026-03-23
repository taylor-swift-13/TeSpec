def note_to_beats(s):
    """
    Converts a note string to its corresponding beat value.
    'o' -> 4
    'o|' -> 2
    '.|' -> 1
    Otherwise -> None
    """
    if s == "o":
        return 4
    elif s == "o|":
        return 2
    elif s == ".|":
        return 1
    else:
        return None

def join(sep, l):
    """
    Joins a list of strings with a separator, matching the Coq join implementation.
    """
    if not l:
        return ""
    if len(l) == 1:
        return l[0]
    return l[0] + sep + join(sep, l[1:])

def _orig_parse_music_spec(music_string, output):
    """
    Checks if the music_string can be parsed into the given output list of beats.
    The spec requires that:
    1. If music_string is empty, output must be empty.
    2. If music_string is not empty, there must exist a list of notes that join
       to music_string and whose beat values match the output list.
    """
    if music_string == '' and output == []:
        return True
    if music_string != '':
        notes = music_string.split(' ')
        if len(notes) == len(output):
            for (n, r) in zip(notes, output):
                if note_to_beats(n) != r:
                    return False
            return True
    return False

def parse_music_spec(music_string, output):
    return bool(_orig_parse_music_spec(music_string, output))
