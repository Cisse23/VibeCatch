FRONT_PAGE = '//nav//a[2]/img'

LOGIN_PAGE = 'body > nav > div > div.buttons > a.login'
USERNAME_FIELD = '//*[@id="username"]'
PASSWORD_FIELD = '//*[@id="password"]'
LOGIN_BUTTON = 'body > div.dialog.open > div.dialog-content > form > div.row.hiddenBySpinner > input'
LOGIN_BUTTON2 = '//input[@value= "Login"]'
LOG_OUT_ELEMENT = '//a[contains(text(), "Log out")]'
ALLOW_COOKIES = '//*[@id="adroll_allow_all"]'

# Create new poll (arkadaşındaki gibi)
CREATE_A_NEW_POLL = '//*[@id="masterContainer"]/vibe-list/div[3]/div/a'
# Fallback'lar (isteğe bağlı kullan)
CREATE_A_NEW_POLL_TEXT = 'xpath=//a[contains(., "Create a new poll")]'
CREATE_A_NEW_POLL_BTN  = 'xpath=//a[contains(@class,"add-project")]'

POLL_NAME_FIELD = '//*[@id="addProjectName"]'
CREATE_QWL_POLL = 'text="Create a QWL poll"'
CREATE_CUSTOM_POLL = 'text="Create a custom poll"'
CREATE_360_FEEDBACK_POLL = 'text="Create a 360 feedback poll"'


POLL_SETTINGS2 = '//div[contains(@class,"projectRow")]//a[contains(text(),"${POLL_NAME}")]/../../../div[contains(@class,"settings")]//div[contains(@class,"actions")]/a[3]'
POLL_SETTINGS  = '//*[@id="masterContainer"]/vibe-list/div[3]/div/div[2]/div/div[5]/div/a[3]/i'
POLL_SETTINGS_FIRST = 'xpath=(//*[@id="masterContainer"]//a[@mattooltip="Change poll\'s settings"])[1]'
POLL_SETTINGS_LAST  = 'xpath=(//*[@id="masterContainer"]//a[@mattooltip="Change poll\'s settings"])[last()]'
POLL_SETTINGS_BY_NAME_CSS = 'css=.projectRow:has(.project-name:has-text("{name}")) .settings-button'
POLL_SETTINGS_BY_NAME_XPATH = '//div[contains(@class,"projectRow")][ .//a[contains(@class,"project-name")][normalize-space(.)="{name}"]]//a[@mattooltip="Change poll\'s settings"]'

REMOVE_QWL_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div'
REMOVE_QWL_2 = '//*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div[2]/vibe-settings-remove-section/div/a[6]'
REMOVE_QWL_3 = 'text="Delete now"'

REMOVE_CUSTOM_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[19]/div[1]'
REMOVE_CUSTOM_2 = 'xpath=//vibe-settings-remove-section//div[contains(@class, "form-group") and contains(@class, "text-center")]//a[contains(@class, "btn-danger")][last()]'
REMOVE_CUSTOM_3 = 'text="Delete now"'

REMOVE_360_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[15]/div'
REMOVE_360_1_ELEMENT = 'xpath=//*[@id="masterContainer"]//vibe-settings-advanced-button[15]'
REMOVE_360_2 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[15]/div[2]/vibe-settings-remove-section/div/a'
REMOVE_360_3 = 'text="Delete now"'

DESTROY_FIELD = 'css=vibe-modal-prompt input'
DELETE_OK = 'text="OK"'
WELCOME_STATE = 'text="Welcome!"'

EDIT_QWL_NAME_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div'
EDIT_QWL_NAME_2 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div'
EDIT_QWL_NAME_FIELD = '//*[@id="projectName"]'
EDIT_QWL_NAME_SAVE = '//*[@id="save"]'

EDIT_CUSTOM_NAME_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div'
EDIT_CUSTOM_NAME_2 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div'
EDIT_CUSTOM_NAME_FIELD = '//*[@id="projectName"]'
EDIT_CUSTOM_NAME_SAVE = '//*[@id="save"]'

EDIT_360_NAME_1 = '//*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div'
EDIT_360_NAME_FIELD = '//*[@id="projectName"]'
EDIT_360_NAME_SAVE = '//*[@id="save"]'

CUSTOM_ADD_QUESTIONS_1 = "xpath=//div[@class='well projectResources']//a[contains(., 'Add questions')]"
CUSTOM_ADD_QUESTIONS_FIELD = '//*[@id="customQuestionText"]'
CUSTOM_ADD_QUESTIONS_2 = "xpath=//div[@class='buttonContainer']//button[contains(., 'Add questions')]"
CUSTOM_ADD_QUESTIONS_SAVE = '//*[@id="save"]'

ALL_USERS_PAGE = 'body > vibe-app > nav > a:nth-child(4)'
EMAIL_GROUPS_BUTTON = '//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[1]'
ADD_NEW_EMAIL_GROUP = '//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/a'
NEW_EMAIL_GROUP_NAME_FIELD = '//*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[2]/input'
NEW_EMAIL_GROUP_OK = '//*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[3]/button[1]'
ALL_USERS_STATE = 'text="Testaus"'
RENAME_EMAIL_GROUP = 'xpath=(//*[@id="masterContainer"]//vibe-organization-emails//a[1]/i)[last()]'
RENAME_EMAIL_GROUP_FIELD = 'xpath=//vibe-modal-prompt//input'
RENAME_EMAIL_GROUP_OK = 'xpath=//vibe-modal-prompt//button[1]'
REMOVE_EMAILGROUP_BUTTON = '//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[41]/a[4]/i'
REMOVE_EMAIL_GROUP_BUTTON = REMOVE_EMAILGROUP_BUTTON
REMOVE_EMAIL_GROUP_OK = '//*[@id="mat-mdc-dialog-1"]/div/div/vibe-modal-confirm/vibe-modal-borders/mat-dialog-content/div/div/div[2]/button[1]'
LAST_EMAIL_GROUP = '//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]'
ADD_EMAILS_BUTTON = 'xpath=//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]/vibe-email-entry/div/div/a'
EMAIL_FIELD = 'xpath=(//vibe-email-entry-modal//textarea)[last()]'
EMAIL_ADD_BUTTON = 'xpath=(//vibe-email-entry-modal//button)[last()]'

ADD_NEW_PROJECT = '(//a[contains(@class, "add-project")])[1]'
CREATE_QWL_POLL_BUTTON = 'text="Create a QWL poll"'
QWL_TYPE_OPTIONS = '//select[option[@value="complete"]]'
ORGANIZATION_TYPE_OPTIONS = '//select[option[contains(text(),"traditional")]]'
HIDE_VECTOR_GRAPHS_CHECKBOX = '//input[@type="checkbox"]'

CREATE_CUSTOM_POLL_BUTTON = 'text="Create a custom poll"'
TYPE_QUESTIONS_FIELD = '//*[@id="customQuestionText"]'
ADD_QUESTIONS_BUTTON = '//a[contains(text(),"Add questions")]'
ADD_QUESTIONS_BUTTON2 = '//button[contains(text(),"Add questions")]'

CREATE_360_POLL_BUTTON = '//button[normalize-space()="Create a 360 feedback poll"]'
ADD_QUESTION_BUTTON = '//vibe-settings-resources//a[contains(text(), "Add")]'
SELECT_NEW_QUESTION = '//select[@id="readyMade"]'
CLICK_FIRST_CHOICE = '(//a[@class="mat-mdc-tooltip-trigger btn btn-minimal"][normalize-space()="Select"])[1]'
ADD_SELECTED_QUESTION = '//button[normalize-space()="Add 1 selected question"]'

QUANTATIVE_0 = '//form-root/div/div[not(@hidden)]//a[@title="Quantity needs to be increased dramatically"]'
QUANTATIVE_1 = '//form-root/div/div[not(@hidden)]//a[@title="Quantity needs to be increased considerably"]'
QUANTATIVE_2 = '//form-root/div/div[not(@hidden)]//a[@title="Quantity needs to be increased somewhat"]'
QUANTATIVE_3 = '//form-root/div/div[not(@hidden)]//a[@title="Quantity needs to be increased slightly"]'
ALL_GOOD_4 = '//form-root/div/div[not(@hidden)]//a[@title="Quantity and quality are good"]'
QUALITY_3 = '//form-root/div/div[not(@hidden)]//a[@title="Quality needs to be improved slightly"]'
QUALITY_2 = '//form-root/div/div[not(@hidden)]//a[@title="Quality needs to be improved somewhat"]'
QUALITY_1 = '//form-root/div/div[not(@hidden)]//a[@title="Quality needs to be improved considerably"]'
QUALITY_0 = '//form-root/div/div[not(@hidden)]//a[@title="Quality needs to be improved dramatically"]'
NEXT_BUTTON_FEEDBACK = '//a[@class="nextButton"]'
NEXT_PAGE_BUTTON_QWL_POLL = '//a[contains(@class,"nextPage")]'
SEND_FEEDBACK_BUTTON = '//span[@class="pageButton sendFeedbackPageButton nextPage"]'
THANK_YOU_FEEDBACK_MESSAGE = '//div[normalize-space(text())="Thank you for your feedback!"]'

CREATE_NEW_POLL_BUTTON_FIRST = 'xpath=(//div[@class="addProjectButton"]//a[contains(., "Create a new poll")])[1]'
CREATE_360_FEEDBACK_BUTTON = 'text=Create a 360 feedback poll'
POLL_FORM_LINK = '//*[@class="relativeLinkToForm"]'
EVALUATOR_NAME_FIELD = 'xpath=//*[@placeholder="Enter your name here"]'
SETTINGS_LINK = '//div[contains(@class,"project-navigation")]//a[normalize-space(.)="Settings"]'
SETTINGS_LINK_ACTIVE = '//div[@class="project-navigation"]/a[@class="selected" and normalize-space(.)="Settings"]'
NEXT_BUTTON_360_POLL_FORM = '//*[@class="nextButton"]'
RATING_BUTTONS_CONTAINER = '//*[@class="threesixtyRatingButtons sideBySideContainer"]'
RATING_OPTIONS = '//*[@class="ratingButton unrated"]'
NEXTQUESTION_BUTTON_360_POLL_FORM = '//*[@class="pageButton roundPageButton nextPage"]'
SUBMIT_EVALUATION_BUTTON = '//*[@class="pageButton sendFeedbackPageButton nextPage"]'
