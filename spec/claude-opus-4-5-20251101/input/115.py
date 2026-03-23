def sum_list(l):
    return sum(l)

def ceil_div(a, b):
    return (a + b - 1) // b

def max_fill_spec(grid, capacity, result):
    if capacity <= 0:
        return False
    
    for row in grid:
        for x in row:
            if x != 0 and x != 1:
                return False
                
    expected_result = 0
    for row in grid:
        expected_result += ceil_div(sum_list(row), capacity)
        
    return result == expected_result
