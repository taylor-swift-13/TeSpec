def string_to_list(s):
    return list(s)

def list_to_string(l):
    return "".join(l)

def encode_cyclic_list(l):
    res = []
    i = 0
    while i + 2 < len(l):
        res.append(l[i+1])
        res.append(l[i+2])
        res.append(l[i])
        i += 3
    while i < len(l):
        res.append(l[i])
        i += 1
    return res

def encode_cyclic_spec(s, res):
    return res == list_to_string(encode_cyclic_list(string_to_list(s)))

def decode_cyclic_list(l):
    res = []
    i = 0
    while i + 2 < len(l):
        res.append(l[i+2])
        res.append(l[i])
        res.append(l[i+1])
        i += 3
    while i < len(l):
        res.append(l[i])
        i += 1
    return res

def decode_cyclic_spec(s, res):
    return res == list_to_string(decode_cyclic_list(string_to_list(s)))
