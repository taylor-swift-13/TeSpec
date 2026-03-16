
def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 2:
            return False
        game, guess = input
        if isinstance(game, (str, bytes)) or isinstance(guess, (str, bytes)):
            return False
        try:
            n = len(game)
            m = len(guess)
        except Exception:
            return False
        if n != m or n < 0:
            return False
        # Ensure iterability
        try:
            iter(game)
            iter(guess)
        except Exception:
            return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return False
        game, guess = input
        if isinstance(output, (str, bytes)):
            return False
        try:
            n = len(game)
            out_len = len(output)
        except Exception:
            return False
        if out_len != n:
            return False
        try:
            # Iterate through elements and check absolute differences
            it_game = iter(game)
            it_guess = iter(guess)
            it_out = iter(output)
            count = 0
            while True:
                try:
                    g = next(it_game)
                    h = next(it_guess)
                    o = next(it_out)
                    count += 1
                except StopIteration:
                    break
                try:
                    diff = h - g
                except Exception:
                    return False
                try:
                    ad = abs(diff)
                except Exception:
                    return False
                if o != ad:
                    return False
                try:
                    if not (ad >= 0):
                        return False
                except Exception:
                    return False
            # Ensure all iterators are exhausted exactly at n elements
            if count != n:
                return False
            try:
                next(it_out)
                return False
            except StopIteration:
                pass
            return True
        except Exception:
            return False
    except Exception:
        return False

def _impl(game,guess):
    """I think we all remember that feeling when the result of some long-awaited
    event is finally known. The feelings and thoughts you have at that moment are
    definitely worth noting down and comparing.
    Your task is to determine if a person correctly guessed the results of a number of matches.
    You are given two arrays of scores and guesses of equal length, where each index shows a match. 
    Return an array of the same length denoting how far off each guess was. If they have guessed correctly,
    the value is 0, and if not, the value is the absolute difference between the guess and the score.


    example:

    compare([1,2,3,4,5,1],[1,2,3,4,2,-2]) -> [0,0,0,0,3,3]
    compare([0,5,0,0,0,4],[4,1,1,0,0,-2]) -> [4,4,1,0,0,6]"""
    return [abs(game[i] - guess[i]) for i in range(len(game))]

def compare(game,guess):
    _input = (game, guess)
    assert precondition(_input)
    _output = _impl(game, guess)
    assert postcondition(_input, _output)
    return _output
