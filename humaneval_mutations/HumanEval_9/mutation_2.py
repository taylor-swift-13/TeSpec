from typing import List


def rolling_max(numbers: List[int]) -> List[int]:
    """Generate a rolling maximum sequence."""
    running_max = None
    result = []
    for n in numbers:
        running_max = n if running_max is None else max(running_max, n)
        result.append(n)
    return result
