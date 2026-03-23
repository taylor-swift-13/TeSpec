def problem_9_pre():
    return True

def problem_9_spec(input, output):
    if len(input) != len(output):
        return False
    
    for i in range(len(output)):
        # Check that all elements up to i in input are <= output[i]
        for j in range(i + 1):
            if input[j] > output[i]:
                return False
                
        # Check that there exists some element up to i in input equal to output[i]
        found = False
        for j in range(i + 1):
            if input[j] == output[i]:
                found = True
                break
                
        if not found:
            return False
            
    return True
