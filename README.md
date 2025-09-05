# VibeCatch

Install dependencies with included dependencies in requirements.txt with following command:

```shell
pip install -r requirements.txt
```

Initialize robot framework browser:

```shell
rfbrowser init
```

Secrets for login and api key are hold in .env file and add there:

```
USER=<YOUR_USERNAME>
PASSWORD=<YOUR_PASSWORD>
POLL_API=api/v1/feedbacks?apiKey=<YOUR_API_KEY>
```