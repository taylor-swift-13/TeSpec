def fruit_distribution_spec(apples: int, oranges: int, n: int, result: int) -> bool:
    return (apples >= 0 and
            oranges >= 0 and
            n >= 0 and
            n - apples - oranges >= 0 and
            result == n - apples - oranges)
