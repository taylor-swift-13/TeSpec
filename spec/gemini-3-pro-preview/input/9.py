def rolling_max_spec(numbers, result):
    if len(numbers) != len(result):
        return False
    
    for i in range(len(numbers)):
        prefix = numbers[:i+1]
        current_max = result[i]
        
        if current_max not in prefix:
            return False
            
        for x in prefix:
            if x > current_max:
                return False
                
    return True
