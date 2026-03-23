def uppercaseb(n):
    return 65 <= n <= 90

def lowercaseb(n):
    return 97 <= n <= 122

def swap_case(c):
    n = ord(c)
    if uppercaseb(n):
        return chr(n + 32)
    elif lowercaseb(n):
        return chr(n - 32)
    else:
        return c

def vowelb(n):
    return (n == 65 or n == 69 or n == 73 or n == 79 or n == 85 or
            n == 97 or n == 101 or n == 105 or n == 111 or n == 117)

def vowel_change(c):
    n = ord(c)
    if vowelb(n):
        return chr(n + 2)
    else:
        return c

def encode_char(c):
    return vowel_change(swap_case(c))

def string_map(f, s):
    return "".join(f(c) for c in s)

def encode_fun(message):
    return string_map(encode_char, message)

def encode_spec(message, encoded):
    return encoded == encode_fun(message)
