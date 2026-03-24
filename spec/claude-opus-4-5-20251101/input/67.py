def _orig_fruit_distribution_spec(apples: int, oranges: int, n: int, output: int) -> bool:
    return apples >= 0 and oranges >= 0 and (n >= 0) and (n - apples - oranges >= 0) and (output == n - apples - oranges)

# Old incorrect translation:
# def fruit_distribution_spec(s, n, output):
#     return bool(_orig_fruit_distribution_spec(s, n, output[0], output[1]))
def fruit_distribution_spec(s, n, output):
    words = s.split(" ")
    if len(words) < 4:
        return False
    try:
        apples = int(words[0])
        oranges = int(words[3])
    except (TypeError, ValueError):
        return False
    return bool(_orig_fruit_distribution_spec(apples, oranges, n, output))
