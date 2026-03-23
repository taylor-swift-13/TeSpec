def count_depth_aux(l, cnt, max_d):
    for c in l:
        if c == '(':
            cnt = cnt + 1
        elif c == ')':
            cnt = cnt - 1
        
        # max_d' := Z.max max_d cnt'
        if cnt > max_d:
            max_d = cnt
            
    return max_d

def count_depth(s):
    return count_depth_aux(list(s), 0, 0)

def split_and_filter(l, acc):
    # l is a list of characters
    # acc is a list of characters (representing the reversed accumulator)
    output = []
    current_acc = list(acc)
    
    for c in l:
        if c == ' ':
            if not current_acc:
                continue
            else:
                # In Coq: string_of_list_ascii (rev acc)
                # acc is reversed, so rev acc is normal order.
                # current_acc is [c_n, ..., c_1]
                # We want [c_1, ..., c_n]
                word = "".join(current_acc[::-1])
                output.append(word)
                current_acc = []
        else:
            # In Coq: split_and_filter cs (c :: acc)
            # c :: acc prepends c to acc.
            current_acc.insert(0, c)
    
    # Base case: match l with []
    if current_acc:
        word = "".join(current_acc[::-1])
        output.append(word)
        
    return output

def _orig_parse_nested_parens_spec(paren_string, output):
    words = split_and_filter(list(paren_string), [])
    calculated_depths = [count_depth(w) for w in words]
    return output == calculated_depths

def parse_nested_parens_spec(paren_string, output):
    return bool(_orig_parse_nested_parens_spec(paren_string, output))
