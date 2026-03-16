from typing import Any, List


def filter_integers(values: List[Any]) -> List[int]:
    """Filter values, but incorrectly excludes zero."""
    return [x for x in values if isinstance(x, int) and x != 0]
