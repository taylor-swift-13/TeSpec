def split_aux(s, acc):
    output = []
    current_acc = acc
    for c in s:
        if c == " ":
            if current_acc != "":
                output.append(current_acc)
            current_acc = ""
        else:
            current_acc += c
    if current_acc != "":
        output.append(current_acc)
    return output

def split_spaces(s):
    return split_aux(s, "")

def count_occurrences(target, l):
    return len([x for x in l if x == target])

def get_max_count(l):
    if not l:
        return 0
    return max([count_occurrences(x, l) for x in l])

def lookup(k, l):
    for (key, val) in l:
        if key == k:
            return val
    return None

# Old incorrect translation:
# def _orig_histogram_spec(test, output):
#     words = split_spaces(test)
#     mx = get_max_count(words)
#     if not words:
#         return output == []
#     keys = [k for (k, v) in output]
#     if len(keys) != len(set(keys)):
#         return False
#     for (k, v) in output:
#         if v != mx:
#             return False
#         if count_occurrences(k, words) != mx:
#             return False
#     for k in words:
#         if count_occurrences(k, words) == mx:
#             if lookup(k, output) != mx:
#                 return False
#     return True
def _orig_histogram_spec(test, output):
    words = split_spaces(test)
    mx = get_max_count(words)
    if not words:
        return output == {}
    if not isinstance(output, dict):
        return False
    for k, v in output.items():
        if not isinstance(k, str) or not isinstance(v, int):
            return False
        if v != mx:
            return False
        if count_occurrences(k, words) != mx:
            return False
    for k in words:
        if count_occurrences(k, words) == mx:
            if output.get(k) != mx:
                return False
    return True

def histogram_spec(test, output):
    return bool(_orig_histogram_spec(test, output))
