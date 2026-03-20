from typing import Any, List


def filter_integers(values: List[Any]) -> List[int]:
    """Filter values, but incorrectly drops bools."""
    return [x for x in values if type(x) is int]
