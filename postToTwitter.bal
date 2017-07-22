import org.wso2.ballerina.connectors.twitter;

import ballerina.lang.jsons;
import ballerina.lang.messages;
import ballerina.lang.system;

string consumerKey = "y76e1sGq7CfdfMZhVLn6x84wC";
string consumerSecret = "EolV7ImcqHxX4AAxIa4neJAtCptqg8iyvlK7SkhW6dOI2c217N";
string accessToken = "2841068630-JhDia4q0f05FeX9rMBZ0pQzDvWgjV79BYHobSOe";
string accessTokenSecret = "iXC4yyGPERasALQ4S6SXDfZlpzBMBASqwV3aD3JLvaC30";

message tweetResponse;
json tweetJSONResponse;

twitter:ClientConnector twitterConnector;

function main (string[] args) {
    postTweet("Colombo");
}

function postTweet(string post){
    twitterConnector= create twitter:ClientConnector(consumerKey,consumerSecret,accessToken,accessTokenSecret);
    tweetResponse=twitter:ClientConnector.tweet(twitterConnector, post);
    tweetJSONResponse = messages:getJsonPayload(tweetResponse);
    system:println(jsons:toString(tweetJSONResponse));
}