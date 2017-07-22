import org.wso2.ballerina.connectors.twitter;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

string consumerKey = "xxxxxxxxxxxxxxxxxxxxxxxxxx";
string consumerSecret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
string accessToken = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
string accessTokenSecret = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

message tweetResponse;
json tweetJSONResponse;

twitter:ClientConnector twitterConnector;

function main (string[] args) {
    //postTweet("Colombo");
}

function postTweet(string post){
    twitterConnector= create twitter:ClientConnector(consumerKey,consumerSecret,accessToken,accessTokenSecret);
    tweetResponse=twitter:ClientConnector.tweet(twitterConnector, post);
    tweetJSONResponse = messages:getJsonPayload(tweetResponse);
    system:println(jsons:toString(tweetJSONResponse));
}
