def at_most_two_digitsb(z):
    return abs(z) <= 99

def add_elements_spec(arr, k, res):
    if not (1 <= len(arr) <= 100):
        return False
    if not (1 <= k <= len(arr)):
        return False
    
    filtered_sum = sum(x for x in arr[:k] if at_most_two_digitsb(x))
    return res == filtered_sum
