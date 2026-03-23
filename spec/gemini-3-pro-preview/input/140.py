def count_consecutive_spaces(s: str) -> int:
    count = 0
    for c in s:
        if c == ' ':
            count += 1
        else:
            break
    return count

def skip_n(n: int, s: str) -> str:
    return s[n:]

def fix_spaces_rel(text: str, output: str) -> bool:
    expected = []
    i = 0
    n = len(text)
    while i < n:
        if text[i] != ' ':
            expected.append(text[i])
            i += 1
        else:
            # Calculate consecutive spaces starting from current position
            count = count_consecutive_spaces(text[i:])
            
            if count <= 2:
                # FS_Space_Short: replace one space with '_' and recurse on the rest (advance by 1)
                expected.append('_')
                i += 1
            else:
                # FS_Space_Long: replace n spaces with '-' and recurse on the rest (advance by n)
                expected.append('-')
                i += count
                
    return "".join(expected) == output

def _orig_fix_spaces_spec(text: str, output: str) -> bool:
    return fix_spaces_rel(text, output)

def fix_spaces_spec(text, output):
    return bool(_orig_fix_spaces_spec(text, output))
