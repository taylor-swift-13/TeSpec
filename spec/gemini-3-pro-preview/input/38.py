def string_to_list(s):
    return list(s)

def list_to_string(l):
    return "".join(l)

def encode_cyclic_list(l):
    output = []
    i = 0
    while i + 2 < len(l):
        output.append(l[i+1])
        output.append(l[i+2])
        output.append(l[i])
        i += 3
    while i < len(l):
        output.append(l[i])
        i += 1
    return output

def encode_cyclic_spec(s, output):
    return output == list_to_string(encode_cyclic_list(string_to_list(s)))

def decode_cyclic_list(l):
    output = []
    i = 0
    while i + 2 < len(l):
        output.append(l[i+2])
        output.append(l[i])
        output.append(l[i+1])
        i += 3
    while i < len(l):
        output.append(l[i])
        i += 1
    return output

def _orig_decode_cyclic_spec(s, output):
    return output == list_to_string(decode_cyclic_list(string_to_list(s)))

def decode_cyclic_spec(s, output):
    return bool(_orig_decode_cyclic_spec(s, output))
