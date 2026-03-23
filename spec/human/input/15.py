def string_of_nat(n: int) -> str:
    return str(n)

def seq_string(start: int, limit: int) -> str:
    return " ".join(str(i) for i in range(start, start + limit + 1))

def string_sequence_impl(n: int) -> str:
    return seq_string(0, n)

def _orig_problem_15_pre(n: int) -> bool:
    return True

def _orig_problem_15_spec(n: int, output: str) -> bool:
    return output == string_sequence_impl(n)

def problem_15_pre(n):
    return bool(_orig_problem_15_pre(n))

def problem_15_spec(n, output):
    return bool(_orig_problem_15_spec(n, output))
