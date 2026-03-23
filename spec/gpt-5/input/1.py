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
    current_cnt = cnt
    current_group = group
    current_acc = list(acc)
    
    for a in s:
        cnt_prime = update_cnt(current_cnt, a)
        group_prime = update_group(current_group, a)
        
        if cnt_prime == 0 and group_prime == "":
            # process_cons_zero_empty:
            # In Coq, this rule requires the final result to exactly match the current accumulator.
            # If they don't match at this exact point, the rule cannot be applied.
            if current_acc != final:
                return False
            current_cnt = cnt_prime
            current_group = ""
        elif cnt_prime == 0 and group_prime != "":
            # process_cons_zero_nonempty:
            current_acc.append(group_prime)
            current_cnt = cnt_prime
            current_group = ""
        else:
            # process_cons_nonzero:
            current_cnt = cnt_prime
            current_group = group_prime
            
    # process_nil:
    return current_acc == final

def _orig_separate_paren_groups_spec(paren_string, results):
    return process_string(paren_string, 0, '', [], results)

def separate_paren_groups_spec(paren_string, output):
    return bool(_orig_separate_paren_groups_spec(paren_string, output))
