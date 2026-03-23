def encode_shift(s: str):
    """
    returns encoded string by shifting every character by 5 in the alphabet.
    """
    return "".join([chr(((ord(ch) + 5 - ord("a")) % 26) + ord("a")) for ch in s])

import builtins

def ord(ch):
    """
    Converts a character to its ASCII integer value.
    In Coq: Definition ord (ch : ascii) : Z := Z.of_nat (nat_of_ascii ch).
    """
    return builtins.ord(ch)

def chr(n):
    """
    Converts an integer to its ASCII character.
    In Coq: Definition chr (n : Z) : ascii := ascii_of_nat (Z.to_nat n).
    """
    return builtins.chr(int(n))

# In Coq: Definition ord_a : Z := ord "a"%char.
ord_a = ord('a')

def encode_shift_char(ch):
    """
    Shifts a character by 5 positions forward in the alphabet.
    In Coq: Definition encode_shift_char (ch : ascii) : ascii :=
      chr (((ord ch + 5 - ord_a) mod 26) + ord_a).
    """
    return chr(((ord(ch) + 5 - ord_a) % 26) + ord_a)

def decode_shift_char(ch):
    """
    Shifts a character by 5 positions backward in the alphabet.
    In Coq: Definition decode_shift_char (ch : ascii) : ascii :=
      chr (((ord ch - ord_a - 5 + 26) mod 26) + ord_a).
    """
    return chr(((ord(ch) - ord_a - 5 + 26) % 26) + ord_a)

def string_to_list(s):
    """
    Converts a string to a list of characters.
    """
    return list(s)

def list_to_string(l):
    """
    Converts a list of characters back to a string.
    """
    return "".join(l)

def encode_shift(s):
    """
    Applies encode_shift_char to every character in a string.
    """
    return list_to_string([encode_shift_char(c) for c in string_to_list(s)])

def decode_shift(s):
    """
    Applies decode_shift_char to every character in a string.
    """
    return list_to_string([decode_shift_char(c) for c in string_to_list(s)])

def decode_shift_spec(s, result):
    """
    Specification for the decode_shift function.
    Returns True if result matches the decoded string and satisfies the uniqueness property.
    """
    # First part of the spec: result = decode_shift s
    if result != decode_shift(s):
        return False
    
    # Second part of the spec: forall original : string, encode_shift original = s -> result = original.
    # This part is true if s is not in the range of encode_shift (vacuously true)
    # or if s has a unique pre-image under encode_shift.
    
    # encode_shift_char always returns a character in 'a'-'z'.
    # So encode_shift(original) always returns a string of 'a'-'z'.
    
    if s == "":
        # The only string that encodes to "" is "".
        # So the pre-image is unique.
        return True
        
    for c in s:
        if not ('a' <= c <= 'z'):
            # s is not in the range of encode_shift.
            # The forall is vacuously true.
            return True
            
    # If s is non-empty and only contains 'a'-'z', it has multiple pre-images
    # because encode_shift_char is not injective on the 8-bit ascii set (0-255).
    # For example, encode_shift_char('a') == encode_shift_char(chr(97+26)).
    # Since there are multiple pre-images, the forall property fails.
    return False

def _impl(s: str):
    return "".join([chr((ord(ch) - ord("a") - 5 + 26) % 26 + ord("a")) for ch in s])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(decode_shift_spec(*input, output))

def decode_shift(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
