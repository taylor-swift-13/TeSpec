def is_sorted_ascending(l):
    return all(l[i] <= l[i+1] for i in range(len(l) - 1))

def is_sorted_descending(l):
    return all(l[i] >= l[i+1] for i in range(len(l) - 1))

def is_permutation(l1, l2):
    return sorted(l1) == sorted(l2)

def sort_array_spec(array, result):
    if len(array) == 0:
        return result == []
    elif len(array) == 1:
        return result == [array[0]]
    else:
        first = array[0]
        last = array[-1]
        
        if not is_permutation(array, result):
            return False
            
        if (first + last) % 2 == 0:
            return is_sorted_descending(result)
        else:
            return is_sorted_ascending(result)
