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

def parse_music_spec(music_string, result):
    """
    Checks if the music_string can be parsed into the given result list of beats.
    The spec requires that:
    1. If music_string is empty, result must be empty.
    2. If music_string is not empty, there must exist a list of notes that join
       to music_string and whose beat values match the result list.
    """
    # Case 1: (music_string = "" /\ result = [])
    if music_string == "" and result == []:
        return True
    
    # Case 2: (music_string <> "" /\ exists notes, join " " notes = music_string /\ Forall2 ...)
    if music_string != "":
        # Since note_to_beats only returns Some for strings without spaces ("o", "o|", ".|"),
        # any valid 'notes' list must consist of strings without spaces.
        # Therefore, the only possible witness for 'notes' is music_string.split(" ").
        notes = music_string.split(" ")
        
        # Forall2 requires the lists to have the same length.
        if len(notes) == len(result):
            # Check if each note's beat value matches the corresponding result.
            for n, r in zip(notes, result):
                if note_to_beats(n) != r:
                    return False
            return True
            
    return False
