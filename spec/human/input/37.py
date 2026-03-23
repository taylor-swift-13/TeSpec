def problem_37_pre(input):
    return True

def problem_37_spec(input, output):
    if len(input) != len(output):
        return False
    
    # 1. input is a permutation of output
    if sorted(input) != sorted(output):
        return False
    
    # 2. For odd indices, output[i] must equal input[i]
    for i in range(len(input)):
        if i % 2 != 0:
            if output[i] != input[i]:
                return False
                
    # 3. Elements at even indices in output must be sorted in non-decreasing order
    even_elements = [output[i] for i in range(len(output)) if i % 2 == 0]
    if even_elements != sorted(even_elements):
        return False
        
    return True
