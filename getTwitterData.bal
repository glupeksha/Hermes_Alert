import ballerina.lang.system;
import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.strings;
import ballerina.net.http;
import ballerina.net.uri;
import ballerina.utils;
import ballerina.lang.arrays;
import ballerina.lang.maps;


string consumerKey = "y76e1sGq7CfdfMZhVLn6x84wC";
string consumerSecret = "EolV7ImcqHxX4AAxIa4neJAtCptqg8iyvlK7SkhW6dOI2c217N";
string accessToken = "2841068630-JhDia4q0f05FeX9rMBZ0pQzDvWgjV79BYHobSOe";
string accessTokenSecret = "iXC4yyGPERasALQ4S6SXDfZlpzBMBASqwV3aD3JLvaC30";

function main (string[] args) {
    Twitter twitterConnector = create Twitter(consumerKey, consumerSecret, accessToken, accessTokenSecret);
    message tweetResponse = Twitter.search(twitterConnector, "wow awesome");
    json tweetJSONResponse = messages:getJsonPayload(tweetResponse);
    system:println(jsons:toString(tweetJSONResponse));}

function getTweets(){

}

connector Twitter(string consumerKey, string consumerSecret, string accessToken, string accessTokenSecret) {
    http:ClientConnector tweeterEP = create http:ClientConnector("https://api.twitter.com");
    action search(Twitter t, string query) (message) {
        message request = {};
        map parameters = {};
        string urlParams;
        string tweetPath = "/1.1/search/tweets.json";
        query = uri:encode(query);
        parameters["q"] = query;
        parameters["geocode"]="6.9271,79.8612,1mi";
        urlParams = "q=" + query +"&geocode=6.9271,79.8612,1mi";
        constructRequestHeaders(request, "GET", tweetPath, consumerKey, consumerSecret, accessToken,
                                accessTokenSecret, parameters);
        tweetPath = tweetPath + "?" + urlParams;

        message response = http:ClientConnector.get(tweeterEP, tweetPath, request);

        return response;
    }

}

function constructRequestHeaders(message request, string httpMethod, string serviceEP, string consumerKey,
                                 string consumerSecret, string accessToken, string accessTokenSecret, map parameters) {
    int index;
    string paramStr;
    string key;
    string value;

    string timeStamp = strings:valueOf(system:epochTime());
    string nonceString = utils:getRandomString();
    serviceEP = "https://api.twitter.com" + serviceEP;

    parameters["oauth_consumer_key"] = consumerKey;
    parameters["oauth_nonce"] = nonceString;
    parameters["oauth_signature_method"] = "HMAC-SHA1";
    parameters["oauth_timestamp"] = timeStamp;
    parameters["oauth_token"] = accessToken;
    parameters["oauth_version"] = "1.0";

    string[] parameterKeys = maps:keys(parameters);
    string[] sortedParameters = arrays:sort(parameterKeys);
    while (index < sortedParameters.length){
        key =  sortedParameters[index];
        value, _ = (string) parameters[key];
        paramStr = paramStr + key + "=" + value + "&";
        index = index + 1;
    }
    paramStr = strings:subString(paramStr, 0, strings:length(paramStr)-1);
    string baseString = httpMethod + "&" + uri:encode(serviceEP) + "&" + uri:encode(paramStr);
    string keyStr = uri:encode(consumerSecret) + "&" + uri:encode(accessTokenSecret);
    string signature = utils:getHmac(baseString, keyStr, "SHA1");
    string oauthHeaderString = "OAuth oauth_consumer_key=\"" + consumerKey +
                               "\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"" + timeStamp +
                               "\",oauth_nonce=\"" + nonceString + "\",oauth_version=\"1.0\",oauth_signature=\"" +
                               uri:encode(signature) + "\",oauth_token=\"" + uri:encode(accessToken) + "\"";

    messages:setHeader(request, "Authorization", strings:unescape(oauthHeaderString));
}