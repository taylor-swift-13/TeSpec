# 旧版本只检查区间，完全没从字符串里解析苹果和橘子数量。
# def _orig_fruit_distribution_spec(s, n, mangoes):
#     return 0 <= mangoes <= n

def _extract_ints(s):
    nums = []
    cur = ""
    for ch in s:
        if ch.isdigit():
            cur += ch
        elif cur:
            nums.append(int(cur))
            cur = ""
    if cur:
        nums.append(int(cur))
    return nums

def _orig_fruit_distribution_spec(s, n, mangoes):
    nums = _extract_ints(s)
    if len(nums) < 2:
        return False
    apples, oranges = nums[0], nums[1]
    return mangoes == n - apples - oranges

def fruit_distribution_spec(s, n, output):
    return bool(_orig_fruit_distribution_spec(s, n, output))
