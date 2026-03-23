def _orig_strlen_spec(s: str, output: int) -> bool:
    return output == len(s)

def strlen_spec(string, output):
    return bool(_orig_strlen_spec(string, output))
