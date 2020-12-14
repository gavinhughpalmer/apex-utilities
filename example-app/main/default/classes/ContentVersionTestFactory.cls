/**
* @author Gavin Palmer
*
* @date 2018-10-23
**/
public without sharing virtual class ContentVersionTestFactory extends AbstractSObjectTestFactory {

    public String title = 'myFileTitle';
    public String contentUrl = 'content/url';

    public override SObject getSObject() {
        return new ContentVersion(
            ContentUrl = contentUrl,
            Title = title
        );
    }
}
