def ascii_eqb(a: str, b: str) -> bool:
    return a == b

def repeat_space(n: int) -> str:
    return " " * n

def NoSpace(s: str) -> bool:
    return " " not in s

def NonEmpty(s: str) -> bool:
    return len(s) > 0

def build_with_spaces(ks: list, gs: list) -> str:
    if not gs:
        if len(ks) == 1:
            return repeat_space(ks[0])
        else:
            return ""
    else:
        if len(ks) > 0:
            return repeat_space(ks[0]) + gs[0] + build_with_spaces(ks[1:], gs[1:])
        else:
            return ""

def interior_positive_for_groups(ks: list, gs: list) -> bool:
    if not gs:
        return True
    if len(ks) < 2:
        return False
    mid = ks[1:-1]
    return all(k >= 1 for k in mid)

def SplitNonEmptySpaceTokens(s: str, groups: list) -> bool:
    actual_groups = [g for g in s.split(" ") if g]
    return groups == actual_groups

def count_depth_z_aux(s: str, cnt: int, mx: int) -> int:
    for c in s:
        if ascii_eqb(c, '('):
            cnt += 1
        elif ascii_eqb(c, ')'):
            cnt -= 1
        mx = max(mx, cnt)
    return mx

def count_depth(s: str) -> int:
    res = count_depth_z_aux(s, 0, 0)
    return res if res >= 0 else 0

def parse_nested_parens_spec(paren_string: str, depths: list) -> bool:
    groups = [g for g in paren_string.split(" ") if g]
    expected_depths = [count_depth(g) for g in groups]
    return depths == expected_depths
