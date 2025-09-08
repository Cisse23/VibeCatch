import random
from robot.api.deco import keyword
import os
import pandas as pd

class CustomLibrary:

    def __init__(self):
        pass

    @keyword
    def get_random_xpath_answer(self, pool='ALL', seed=None):
        """
        Returns a locator variable name like 'QUANTATIVE_3' that you can dereference
        in Robot as ${${random_locator}}.
        pool: 'ALL' (default), 'QUANTATIVE', 'QUALITY', 'ALL_GOOD', 'POSITIVE', 'NEGATIVE'
        seed: optional int to make random choice reproducible
        """
        buckets = {
            'ALL': [
                'QUANTATIVE_0','QUANTATIVE_1','QUANTATIVE_2','QUANTATIVE_3',
                'ALL_GOOD_4',
                'QUALITY_3','QUALITY_2','QUALITY_1','QUALITY_0'
            ],
            'QUANTATIVE': ['QUANTATIVE_0','QUANTATIVE_1','QUANTATIVE_2','QUANTATIVE_3'],
            'QUALITY':    ['QUALITY_0','QUALITY_1','QUALITY_2','QUALITY_3'],
            'ALL_GOOD':   ['ALL_GOOD_4'],

            # Convenience “sentiments” (tweak as you like)
            'POSITIVE':   ['ALL_GOOD_4','QUALITY_3','QUANTATIVE_3'],
            'NEGATIVE':   ['QUALITY_0','QUANTATIVE_0']
        }

        items = buckets.get(str(pool).upper(), buckets['ALL'])
        if seed is not None:
            random.seed(int(seed))
        return random.choice(items)
    
    @keyword
    def get_random_index_answer(self):
        """
        Returns random index inbetween 3-12.
        """
        random_index = random.randint(3, 12)  
        return random_index
    
    @keyword
    def get_random_custom_poll_answer(self, pool='ALL'):
        """
        Returns a locator variable name like 'POOR_ICON' that you can dereference
        in Robot as ${${random_locator}}.
        pool: 'WORST_ICON','POOR_ICON','AVERAGE_ICON','GOOD_ICON','BEST_ICON'
        """
        buckets = {
            'ALL': [
                'WORST_ICON','POOR_ICON','AVERAGE_ICON','GOOD_ICON',
                'BEST_ICON',
            ],
            'ALL_GOOD':   ['AVERAGE_ICON'],

            # Convenience “sentiments” (tweak as you like)
            'POSITIVE':   ['GOOD_ICON','BEST_ICON'],
            'NEGATIVE':   ['WORST_ICON','POOR_ICON']
        }
        items = buckets.get(str(pool).upper(), buckets['ALL'])
        return random.choice(items)