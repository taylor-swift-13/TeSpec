def is_separator(c: str) -> bool:
    return c == " " or c == ","

def words_string_aux(s: str, acc: str) -> list:
    res = []
    for c in s:
        if is_separator(c):
            if acc == "":
                pass
            else:
                res.append(acc)
                acc = ""
        else:
            acc += c
    if acc != "":
        res.append(acc)
    return res

def words_string_spec(s: str, result: list) -> bool:
    return result == words_string_aux(s, "")
