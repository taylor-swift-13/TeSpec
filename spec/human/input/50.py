def decode_char(c: str) -> str:
    # 旧版本只对小写字母做 Caesar 解码，和 Coq 对任意 ascii 的算术变换不一致：
    # if 'a' <= c <= 'z':
    #     return chr((ord(c) - ord('a') - 5) % 26 + ord('a'))
    # return c
    #
    # Coq:
    #   let n := nat_of_ascii c in
    #   let a := nat_of_ascii "a"%char in
    #   ascii_of_nat (a + (n - a + 21) mod 26).
    # 其中 nat 减法是饱和减法；当 n < a 时，n - a = 0。
    # n = ord(c)
    # a = ord('a')
    # sub = n - a if n >= a else 0
    # return chr((a + (sub + 21) % 26) % 256)
    n = ord(c)
    a = ord('a')
    sub = n - a if n >= a else 0
    return chr((a + (sub + 21) % 26) % 256)

def _orig_problem_50_pre(l_prime: str) -> bool:
    return True

def _orig_problem_50_spec(l_prime: str, l: str) -> bool:
    return l == ''.join((decode_char(c) for c in l_prime))

def problem_50_pre(s):
    return bool(_orig_problem_50_pre(s))

def problem_50_spec(s, output):
    return bool(_orig_problem_50_spec(s, output))
