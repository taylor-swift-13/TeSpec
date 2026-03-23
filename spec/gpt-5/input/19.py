def join_with_space(l):
    """
    Joins a list of strings with a single space between them.
    Equivalent to Coq's join_with_space fixpoint.
    """
    if not l:
        return ""
    return " ".join(l)

def valid_word(s):
    """
    Checks if a string is one of the valid words "zero" through "nine".
    Equivalent to Coq's valid_word Prop.
    """
    valid_words = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    return s in valid_words

def val_of(s):
    """
    Maps valid words to their numeric values (0-9).
    Equivalent to Coq's val_of definition.
    """
    mapping = {
        "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
        "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9
    }
    # Coq's match returns 0 for any string not explicitly listed.
    return mapping.get(s, 0)

def sort_numbers_spec(numbers, result):
    """
    Checks if 'result' is a space-separated string of valid words that is a 
    sorted permutation of the space-separated valid words in 'numbers'.
    Equivalent to Coq's sort_numbers_spec Prop.
    """
    # Case 1: Both numbers and result are empty strings.
    if numbers == "" and result == "":
        return True
    
    # Case 2: exists l l', join_with_space l = numbers /\ Forall valid_word l /\ ...
    # Since valid words do not contain spaces, l must be numbers.split(" ") if numbers is not empty.
    l = [] if numbers == "" else numbers.split(" ")
    l_prime = [] if result == "" else result.split(" ")
    
    # Check join_with_space l = numbers
    if join_with_space(l) != numbers:
        return False
    
    # Check Forall valid_word l
    if not all(valid_word(w) for w in l):
        return False
        
    # Check Permutation l l'
    # In Python, sorted() on a list of strings is a standard way to check for permutation.
    if sorted(l) != sorted(l_prime):
        return False
        
    # Check Sorted (fun s1 s2 => val_of s1 <= val_of s2) l'
    # This checks if every adjacent pair (s1, s2) in l' satisfies val_of(s1) <= val_of(s2).
    for i in range(len(l_prime) - 1):
        if val_of(l_prime[i]) > val_of(l_prime[i+1]):
            return False
            
    # Check result = join_with_space l'
    if join_with_space(l_prime) != result:
        return False
        
    return True
