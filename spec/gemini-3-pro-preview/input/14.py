def all_prefixes_spec(s, res):
    expected = [s[:i+1] for i in range(len(s))]
    return res == expected
