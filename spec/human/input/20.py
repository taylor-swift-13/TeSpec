def problem_20_pre(input):
    return len(input) >= 2

def problem_20_spec(input, output1, output2):
    if len(input) < 2:
        return False
        
    if output1 not in input or output2 not in input:
        return False
        
    if output1 > output2:
        return False
        
    diff = abs(output1 - output2)
    
    for i in range(len(input)):
        for j in range(len(input)):
            if i != j:
                if diff > abs(input[i] - input[j]):
                    return False
                    
    return True
