from typing import List

def open_paren():
    return chr(40)

def close_paren():
    return chr(41)

def space():
    return chr(32)

def is_open(a):
    return a == open_paren()

def is_close(a):
    return a == close_paren()

def is_space(a):
    return a == space()

def update_cnt(cnt, a):
    if is_open(a):
        return cnt + 1
    elif is_close(a):
        return cnt - 1
    else:
        return cnt

def update_group(group, a):
    if not is_space(a):
        return group + a
    else:
        return group

def process_string(s, cnt, group, acc, final):
    curr_cnt = cnt
    curr_group = group
    curr_acc = list(acc)

    for a in s:
        cnt_prime = update_cnt(curr_cnt, a)
        group_prime = update_group(curr_group, a)

        if cnt_prime == 0:
            if group_prime == "":
                if final != curr_acc:
                    return False
                curr_group = ""
            else:
                curr_acc.append(group_prime)
                curr_group = ""
        else:
            curr_group = group_prime

        curr_cnt = cnt_prime

    return curr_acc == final

def separate_paren_groups_spec(paren_string, results):
    return process_string(paren_string, 0, "", [], results)

def _impl(paren_string: str) -> List[str]:
    cnt, group, results = 0, "", []
    for ch in paren_string:
        if ch == "(": cnt += 1
        if ch == ")": cnt -= 1
        if ch != " ": group += ch
        if cnt == 0:
            if group != "": results.append(group)
            group = ""
    return results

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(separate_paren_groups_spec(*input, output))

def separate_paren_groups(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
