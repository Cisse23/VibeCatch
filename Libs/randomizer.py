from robot.api.deco import library, keyword
import random
import string


@library
class Randomizer:
    ROBOT_LIBRARY_SCOPE = "GLOBAL"

    @keyword
    def generate_random_username(self, length=10):
        return ''.join(random.choices(string.ascii_lowercase + string.digits, k=length))

    @keyword
    def generate_random_password(self, length=10):
        return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

    @keyword
    def generate_random_poll_name(self, length=10):
        prefix = "Poll_"
        random_part = ''.join(random.choices(string.ascii_letters + string.digits, k=length))
        return prefix + random_part

    @keyword
    def generate_random_question(self):
        characters = string.ascii_letters + string.digits
        title = ''.join(random.choices(characters, k=20)) + '?'
        return title

    @keyword
    def generate_random_email(self, length=8):
        characters = string.ascii_letters + string.digits
        local_part = ''.join(random.choices(characters, k=length))
        return local_part.lower() + "@gmail.com"