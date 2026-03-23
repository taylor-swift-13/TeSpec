def split_aux(s, acc):
    result = []
    current_acc = acc
    for c in s:
        if c == " ":
            if current_acc != "":
                result.append(current_acc)
            current_acc = ""
        else:
            current_acc += c
    if current_acc != "":
        result.append(current_acc)
    return result

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

def histogram_spec(test, result):
    words = split_spaces(test)
    mx = get_max_count(words)
    
    if not words:
        return result == []
    
    # Check NoDup (map fst result)
    keys = [k for (k, v) in result]
    if len(keys) != len(set(keys)):
        return False
        
    # Check: forall k v, lookup k result = Some v -> v = mx /\ count_occurrences k words = mx
    for (k, v) in result:
        if v != mx:
            return False
        if count_occurrences(k, words) != mx:
            return False
            
    # Check: forall k, In k words -> count_occurrences k words = mx -> lookup k result = Some mx
    for k in words:
        if count_occurrences(k, words) == mx:
            if lookup(k, result) != mx:
                return False
                
    return True
