def tri_spec(n: int, result: list) -> bool:
    if n == 0:
        return result == [1]
    elif n == 1:
        return result == [1, 3]
    else:
        ans = [1, 3]
        for i in range(2, n + 1):
            if i % 2 == 0:
                left = (ans[i-2] if i-2 < len(ans) else 0) + 1 + i // 2
                right = ans[i-1] if i-1 < len(ans) else 0
                if left != right:
                    return False
            else:
                left = (ans[i-2] if i-2 < len(ans) else 0) + (ans[i-3] if i-3 < len(ans) else 0) + 1 + (i + 1) // 2
                right = ans[i-1] if i-1 < len(ans) else 0
                if left != right:
                    return False
        return result == ans

def _impl(n):
    if n == 0: return [1]
    if n == 1: return [1, 3]
    ans = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            ans.append(1 + i / 2)
        else:
            ans.append(ans[-1] + ans[-2] + 1 + (i + 1) / 2)
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(tri_spec(*input, output))

def tri(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
