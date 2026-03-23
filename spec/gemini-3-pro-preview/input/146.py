def FirstDigit(n, d):
    if n < 0:
        return False
    while n >= 10:
        n = n // 10
    return n == d

def IsOddDigit(d):
    return d in [1, 3, 5, 7, 9]

def SpecialCondition(n):
    if n <= 10:
        return False
    if not IsOddDigit(n % 10):
        return False
    
    temp = n
    while temp >= 10:
        temp = temp // 10
    d = temp
    
    return IsOddDigit(d)

def CountSpecial(nums, ans):
    count = 0
    for x in nums:
        if SpecialCondition(x):
            count += 1
    return count == ans

def specialFilter_spec(nums, ans):
    return CountSpecial(nums, ans)
