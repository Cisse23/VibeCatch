#Login
LOGIN_BUTTON = '//a[contains(@class, "login")]'
USERNAME_FIELD = '//*[@id="username"]'
PASSWORD_FIELD = '//*[@id="password"]'
LOGIN_BUTTON2 =  '//input[@value= "Login"]'
LOG_OUT_ELEMENT = '//a[contains(text(), "Log out")]'
#QWL_Poll
ADD_NEW_PROJECT = '(//a[contains(@class, "add-project")])[1]'
ADD_PROJECT_NAME = '//*[@id="addProjectName"]'
CREATE_QWL_POLL_BUTTON = 'text="Create a QWL poll"'
QWL_TYPE_OPTIONS = '//select[option[@value="complete"]]'
ORGANIZATION_TYPE_OPTIONS = '//select[option[contains(text(),"traditional")]]'
HIDE_VECTOR_GRAPHS_CHECKBOX = '//input[@type="checkbox"]'
#Custom_Poll
CREATE_CUSTOM_POLL_BUTTON = 'text="Create a custom poll"'
ADD_QUESTIONS_BUTTON = '//a[contains(text(),"Add questions")]'
TYPE_QUESTIONS_FIELD = '//*[@id="customQuestionText"]'
ADD_QUESTIONS_BUTTON2 = '//button[contains(text(),"Add questions")]'
#create360poll
CREATE_360_POLL_BUTTON = '//button[normalize-space()="Create a 360 feedback poll"]'
ADD_QUESTION_BUTTON = '//vibe-settings-resources//a[contains(text(), "Add")]'
SELECT_NEW_QUESTION = '//select[@id="readyMade"]'
CLICK_FIRST_CHOICE = '(//a[@class="mat-mdc-tooltip-trigger btn btn-minimal"][normalize-space()="Select"])[1]'
ADD_SELECTED_QUESTION = '//button[normalize-space()="Add 1 selected question"]'