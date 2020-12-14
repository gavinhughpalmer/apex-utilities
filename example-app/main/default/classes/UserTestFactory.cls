/**
* @author Gavin Palmer
*
* @date 2019-02-02
**/
@IsTest
public without sharing class UserTestFactory extends AbstractSObjectTestFactory {

    private static final Map<String, Id> PROFILE_IDS_CACHE = new Map<String, Id>();

    public String lastName = 'Test';
    public String email = 'testEmail' + Math.random() + '@test.com';
    public String alias = 'test';
    public String username = email;
    public String nickname = 'test';
    public String locale = 'en_US';
    public String timezone = 'GMT';
    public String profileName = 'Standard User';
    public String languageLocale = 'en_US';
    public String emailEncoding = 'UTF-8';
    public Id managerId;
    public Id roleId;

    public override SObject getSObject() {
        return new User(
            LastName = lastName,
            Email = email,
            Alias = alias,
            Username = uniqueValue + username,
            CommunityNickname = uniqueValue + nickname,
            LocaleSidKey = locale,
            TimeZoneSidKey = timezone,
            ProfileID = getProfileId(),
            LanguageLocaleKey = languageLocale,
            EmailEncodingKey = emailEncoding,
            ManagerId = managerId,
            UserRoleId = roleId
        );
    }

    private Id getProfileId() {
        if (!PROFILE_IDS_CACHE.containsKey(profileName)) {
            PROFILE_IDS_CACHE.put(profileName, [
                SELECT Id
                FROM Profile
                WHERE Name = :profileName
                LIMIT 1
            ].Id);
        }
        return PROFILE_IDS_CACHE.get(profileName);
    }
}
