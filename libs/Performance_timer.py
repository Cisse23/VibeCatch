import time                           # I bring in Python's time module so I can measure how long things take
from robot.api.deco import library, keyword   # I bring in Robot's decorators so I can mark this as a library and keywords
from robot.libraries.BuiltIn import BuiltIn   # I bring in Robot's BuiltIn so I can call other Robot keywords from Python

@library                               # I tell Robot "this whole class is a library you can use"
class PerfTimer:                       # I name my library class PerfTimer

    @keyword("Run And Measure")        # I tell Robot "I am creating a keyword called Run And Measure"
    def run_and_measure(self, threshold_ms: int, keyword_name: str, *args):
        # I define a function that takes: threshold time (ms), the name of a keyword to run, and its arguments

        """
        Run any Robot Framework keyword by name, measure its execution time,
        log the result, and fail if the threshold (ms) is exceeded.

        Usage in .robot:
        Run And Measure    5000    Create Poll    MyPollName
        """
        start = time.time()            # I note the current time right now, so I know when I started
        BuiltIn().run_keyword(keyword_name, *args)   # I run the Robot keyword with the name and arguments I was given
        duration_ms = int((time.time() - start) * 1000)  # I check the time again, subtract start, and turn it into milliseconds
        BuiltIn().log_to_console(                   # I print a message on the console to say how long it took
            f"[Perf] {keyword_name} took {duration_ms} ms (threshold {threshold_ms} ms)"
        )
        if duration_ms > threshold_ms:              # I compare the time with the limit I was given
            raise AssertionError(                   # I stop the test and say it failed if it took too long
                f"{keyword_name} took {duration_ms} ms > {threshold_ms} ms"
            )
        return duration_ms                          # I give back the duration so it can be used if needed