from robot.api.deco import keyword, library
from robot.api import logger
import requests
import json

@library
class ApiRequests:
    def __init__(self):
        self.api_url = 'https://env-5369504.paas.datacenter.fi/api/v1/'

    @keyword
    def pretty_print_json(self, json_data):
        return json.dumps(json_data, indent=4)

    @keyword
    def send_request_params(
        self, api_key, questions=None, startDay=None, startMonth=None, startYear=None,
        endDay=None, endMonth=None, endYear=None, limit=None, offset=None):
        params = {
            "apiKey": api_key,
            "questions": questions or "",
            "startDay": startDay or "",
            "startMonth": startMonth or "",
            "startYear": startYear or "",
            "endDay": endDay or "",
            "endMonth": endMonth or "",
            "endYear": endYear or "",
            "limit": limit or "",
            "offset": offset or ""
        }
        response = requests.get(
            self.api_url + "feedbacks",
            headers={"content-type": "application/json"},
            params=params,
            verify=False  # Disables SSL verification
        )
        # Log the URL
        logger.info(f"\nRequest URL: {response.url}", also_console=True)

        if response.status_code == 200:
            return response.json()
        else:
            return {"error": response.status_code}

    @keyword
    def send_request_url(self, request_url):
        response = requests.get(request_url, headers={"content-type": "application/json"}, verify = False)  #  verify = False Disables SSL verification
        if response.status_code == 200:
            return response.json()
        else: 
            return {"error": response.status_code}
        
    @keyword
    def send_request_apikey(self, api_key):
        try:
            response = requests.get(self.api_url + 'feedbacks?apiKey=' + api_key, headers={"content-type": "application/json"}, verify = False)  #  verify = False Disables SSL verification
            if response.status_code == 200:
                return response.json()
            else: 
                return {"error": response.status_code}
        except requests.exceptions.SSLError as e:
            return {"ssl_error": str(e)}

if __name__ == "__main__":
    test = ApiRequests()
    # testdata = test.send_request_url('https://env-5369504.paas.datacenter.fi/api/v1/feedbacks?apiKey=a3bafe24067b3c2f3487')
    # print(testdata['meta']['total'])
    # data = test.send_request_url('https://env-5369504.paas.datacenter.fi/api/v1/feedbacks?apiKey=d2b6b2c10e01719dbabb&questions=&startDay=&startMonth=&startYear=&endDay=&endMonth=&endYear=&limit=&offset=')
    # print(json.dumps(data, indent=4))
    # failed_request = test.send_request_url(('https://env-5369504.paas.datacenter.fi/api/v1/feedbacks?apiKey=f3487'))
    # print(failed_request)
    print(json.dumps(test.send_request_params('a3bafe24067b3c2f3487', questions='688c7454a787c096fdf07197,688c7454a787c096fdf07198'), indent=4))