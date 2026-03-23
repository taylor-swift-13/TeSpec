def rolling_max_spec(numbers, result):
    if len(numbers) != len(result):
        return False
    
    current_max = 0
    for i in range(len(numbers)):
        current_max = max(current_max, numbers[i])
        if result[i] != current_max:
            return False
            
    return True
