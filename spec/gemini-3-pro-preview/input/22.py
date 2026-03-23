# 旧版本引入了 VInt/VOther 包装类，和官方 _impl 的真实输入类型不一致。
# class VInt:
#     def __init__(self, v):
#         self.v = v
#
#     def __eq__(self, other):
#         if isinstance(other, VInt):
#             return self.v == other.v
#         return False
#
# class VOther:
#     def __eq__(self, other):
#         return isinstance(other, VOther)
#
# def filter_integers_model(l):
#     res = []
#     for item in l:
#         if isinstance(item, VInt):
#             res.append(item.v)
#     return res

def filter_integers_model(l):
    res = []
    for item in l:
        if type(item) is int:
            res.append(item)
    return res

def _orig_filter_integers_spec(values, output):
    return output == filter_integers_model(values)

def filter_integers_spec(values, output):
    return bool(_orig_filter_integers_spec(values, output))
