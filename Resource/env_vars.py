import os
from dotenv import load_dotenv

load_dotenv()

USERNAME=os.getenv('USER')
PASSWORD=os.getenv('PASSWORD')
POLL_API_URL =os.getenv('POLL_API')