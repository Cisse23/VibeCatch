*** Settings ***
Library    Browser


*** Variables ***
${ALLOW_COOKIES}    //*[@id="adroll_allow_all"]
${LOGIN_PAGE}    body > nav > div > div.buttons > a.login
${USERNAME_FIELD}    //*[@id="username"]
${PASSWORD_FIELD}    //*[@id="password"]
${LOGIN_BUTTON}    body > div.dialog.open > div.dialog-content > form > div.row.hiddenBySpinner > input
${CREATE_A_NEW_POLL}    //*[@id="masterContainer"]/vibe-list/div[3]/div/a
${POLL_NAME_FIELD}    //*[@id="addProjectName"]
${CREATE_QWL_POLL}    text="Create a QWL poll"
${CREATE_CUSTOM_POLL}    text="Create a custom poll"
${CREATE_360_FEEDBACK_POLL}    text="Create a 360 feedback poll"
${POLL_SETTINGS}    //*[@id="masterContainer"]/vibe-list/div[3]/div/div[2]/div/div[5]/div/a[3]/i'
${POLL_SETTINGS2}    //*[@id="masterContainer"]/vibe-list/div[3]/div/div[2]/div/div[5]/div/a[3]
${REMOVE_QWL_1}    //*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div
${REMOVE_QWL_2}    //*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div[2]/vibe-settings-remove-section/div/a[6]
${REMOVE_QWL_3}    text="Delete now"
${REMOVE_CUSTOM_1}    //*[@id="masterContainer"]/vibe-settings/div/div[3]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[19]/div[1]
${REMOVE_CUSTOM_2}    xpath=//vibe-settings-remove-section//div[contains(@class, 'form-group') and contains(@class, 'text-center')]//a[contains(@class, 'btn-danger')][last()]
${REMOVE_CUSTOM_3}    text="Delete now"
${REMOVE_360_1}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[15]/div
${REMOVE_360_1_ELEMENT}    xpath=//*[@id="masterContainer"]//vibe-settings-advanced-button[15]
${REMOVE_360_2}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[15]/div[2]/vibe-settings-remove-section/div/a
${REMOVE_360_3}    text="Delete now"
${DESTROY_FIELD}    css=vibe-modal-prompt input
${DELETE_OK}    text="OK"
${WELCOME_STATE}    text="Welcome!"
${EDIT_QWL_NAME_1}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div
${EDIT_QWL_NAME_2}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div
${EDIT_QWL_NAME_FIELD}    //*[@id="projectName"]
${EDIT_QWL_NAME_SAVE}    //*[@id="save"]
${EDIT_CUSTOM_NAME_1}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[18]/div
${EDIT_CUSTOM_NAME_2}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div
${EDIT_CUSTOM_NAME_FIELD}    //*[@id="projectName"]
${EDIT_CUSTOM_NAME_SAVE}    //*[@id="save"]
${EDIT_360_NAME_1}    //*[@id="masterContainer"]/vibe-settings/div/div[2]/vibe-settings-advanced-section/div/vibe-settings-advanced-button[1]/div
${EDIT_360_NAME_FIELD}    //*[@id="projectName"]
${EDIT_360_NAME_SAVE}    //*[@id="save"]
${CUSTOM_ADD_QUESTIONS_1}    xpath=//div[@class='well projectResources']//a[contains(., 'Add questions')]
${CUSTOM_ADD_QUESTIONS_FIELD}    //*[@id="customQuestionText"]
${CUSTOM_ADD_QUESTIONS_2}    xpath=//div[@class='buttonContainer']//button[contains(., 'Add questions')]
${CUSTOM_ADD_QUESTIONS_SAVE}    //*[@id="save"]
${ALL_USERS_PAGE}    body > vibe-app > nav > a:nth-child(4)
${EMAIL_GROUPS_BUTTON}    //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[1]
${ADD_NEW_EMAIL_GROUP}    //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/a
${NEW_EMAIL_GROUP_NAME_FIELD}    //*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[2]/input
${NEW_EMAIL_GROUP_OK}    //*[@id="mat-mdc-dialog-0"]/div/div/vibe-modal-prompt/vibe-modal-borders/mat-dialog-content/div/div/div[3]/button[1]
${ALL_USERS_STATE}    text="Testaus"
${RENAME_EMAIL_GROUP}    xpath=(//*[@id="masterContainer"]//vibe-organization-emails//a[1]/i)[last()]
${RENAME_EMAIL_GROUP_FIELD}    xpath=//vibe-modal-prompt//input
${RENAME_EMAIL_GROUP_OK}    xpath=//vibe-modal-prompt//button[1]
${REMOVE_EMAIL_GROUP_BUTTON}    //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[41]/a[4]/i
${REMOVE_EMAIL_GROUP_OK}    //*[@id="mat-mdc-dialog-1"]/div/div/vibe-modal-confirm/vibe-modal-borders/mat-dialog-content/div/div/div[2]/button[1]
${FRONT_PAGE}    //nav//a[2]/img
${LAST_EMAIL_GROUP}    //*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]
${ADD_EMAILS_BUTTON}    xpath=//*[@id="masterContainer"]/vibe-organization/div/div[3]/vibe-organization-emails/div[2]/div[2]/div/div[last()]/vibe-email-entry/div/div/a
${EMAIL_FIELD}    xpath=(//vibe-email-entry-modal//textarea)[last()]
${EMAIL_ADD_BUTTON}    xpath=(//vibe-email-entry-modal//button)[last()]