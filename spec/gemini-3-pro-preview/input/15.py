def nat_to_string(n):
    """
    Implementation of the Coq Parameter nat_to_string.
    Since the Coq spec leaves this abstract, we provide the standard decimal 
    string representation to ensure executability on concrete inputs.
    This function can be monkey-patched if a different interpretation is needed.
    """
    return str(n)

def string_sequence_spec(n, result):
    """
    Python implementation of the Coq string_sequence_spec.
    
    Coq definition:
      result = String.concat " " (map nat_to_string (seq 0 (S n)))
      
    Logic:
      1. (seq 0 (S n)) generates a list of natural numbers starting at 0 with length n+1.
         This corresponds to [0, 1, ..., n].
      2. map nat_to_string converts each number to a string.
      3. String.concat " " joins the strings with a space separator.
    """
    # Generate the sequence 0 to n (inclusive)
    # We use the global nat_to_string to allow for external overriding (mocking)
    # if a different behavior for the abstract parameter is required.
    sequence_strings = (nat_to_string(i) for i in range(n + 1))
    
    # Join with space
    expected_result = " ".join(sequence_strings)
    
    return result == expected_result
