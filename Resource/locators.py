#Main
FRONT_PAGE = //nav//a[2]/img
 
#Login
LOGIN_BUTTON = '//a[contains(@class, "login")]'
USERNAME_FIELD = '//*[@id="username"]'
PASSWORD_FIELD = '//*[@id="password"]'
LOGIN_BUTTON2 =  '//input[@value= "Login"]'
LOG_OUT_ELEMENT = '//a[contains(text(), "Log out")]'

#Emailgroup
ALL_USERS_PAGE = body > vibe-app > nav > a:nth-child(4)
EMAIL_GROUPS_BUTTON = //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[1]
ADD_NEW_EMAIL_GROUP = //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/a
NEW_EMAIL_GROUP_NAME_FIELD = //*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[2]/input
NEW_EMAIL_GROUP_OK = //*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[3]/button[1]
ALL_USERS_STATE = text="Testaus"
RENAME_EMAIL_GROUP = xpath=(//*[@id="masterContainer"]//vibe-organization-emails//a[1]/i)[last()]
RENAME_EMAIL_GROUP_FIELD = xpath=//vibe-modal-prompt//input
RENAME_EMAIL_GROUP_OK = xpath=//vibe-modal-prompt//button[1]
REMOVE_EMAIL_GROUP_BUTTON = //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[41]/a[4]/i
REMOVE_EMAIL_GROUP_OK = //*[@id="mat-mdc-dialog-1"]/div/div/vibe-modal-confirm/vibe-modal-borders/mat-dialog-content/div/div/div[2]/button[1]
LAST_EMAIL_GROUP = //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]
ADD_EMAILS_BUTTON = xpath=//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]/vibe-email-entry/div/div/a
EMAIL_FIELD = xpath=(//vibe-email-entry-modal//textarea)[last()]
EMAIL_ADD_BUTTON = xpath=(//vibe-email-entry-modal//button)[last()]