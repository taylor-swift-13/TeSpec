def intersperse(numbers, delimeter):
    if not numbers:
        return []
    
    # The Coq definition handles the single element case specifically:
    # | h :: [] => [h]
    # And the recursive step:
    # | h :: t => h :: delimeter :: intersperse t delimeter
    #
    # We implement this iteratively for Python efficiency while preserving behavior.
    
    result = [numbers[0]]
    for x in numbers[1:]:
        result.append(delimeter)
        result.append(x)
        
    return result

def _orig_intersperse_spec(numbers, delimeter, output):
    return output == intersperse(numbers, delimeter)

def intersperse_spec(numbers, delimeter, output):
    return bool(_orig_intersperse_spec(numbers, delimeter, output))
