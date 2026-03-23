class VInt:
    def __init__(self, v):
        self.v = v
        
    def __eq__(self, other):
        if isinstance(other, VInt):
            return self.v == other.v
        return False

class VOther:
    def __eq__(self, other):
        return isinstance(other, VOther)

def filter_integers_model(l):
    res = []
    for item in l:
        if isinstance(item, VInt):
            res.append(item.v)
    return res

def filter_integers_spec(values, result):
    return result == filter_integers_model(values)
