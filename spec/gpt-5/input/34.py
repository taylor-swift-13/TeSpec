def unique_spec(l, res):
    # Check if res is sorted in ascending order
    if res != sorted(res):
        return False
    
    # Check if res has no duplicates
    if len(res) != len(set(res)):
        return False
    
    # Check if the elements in res are exactly the elements in l
    if set(res) != set(l):
        return False
    
    return True
