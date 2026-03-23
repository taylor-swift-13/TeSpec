def problem_34_pre(input):
    return True

def problem_34_spec(input, output):
    # 1. Check if output is sorted
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
            
    # 2. Check if output has unique elements
    if len(set(output)) != len(output):
        return False
        
    # 3. Check if input and output have the same elements
    if set(input) != set(output):
        return False
        
    return True
