def find_closest_elements_spec(numbers, result):
    if len(numbers) < 2:
        return True
    
    a, b = result
    if a > b:
        return False
        
    n = len(numbers)
    
    # Check exists i j : nat, i <> j /\ numbers[i] == a /\ numbers[j] == b
    found = False
    for i in range(n):
        for j in range(n):
            if i != j and numbers[i] == a and numbers[j] == b:
                found = True
                break
        if found:
            break
            
    if not found:
        return False
        
    # Check forall i j : nat, i <> j -> b - a <= abs(numbers[i] - numbers[j])
    for i in range(n):
        for j in range(n):
            if i != j:
                if b - a > abs(numbers[i] - numbers[j]):
                    return False
                    
    return True
