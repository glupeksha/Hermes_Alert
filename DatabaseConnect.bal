import ballerina.data.sql;
import ballerina.lang.system;

sql:ClientConnector db_hermes_alert;

function main (string[] args) {
   openDatabase();
   insertTweet(45343, "handsome vishwa");
   selectTweetByID(45343);
   closeDatabase();
}



function openDatabase () {
    //Create a SQL connector by providing the required database connection
    //pool properties.
    map props = {"jdbcUrl":"jdbc:mysql://localhost:3306/hermes_alert","username":"root","password":""};
    db_hermes_alert  = create sql:ClientConnector(props);
    
    system:println("Database Opened");
}


function closeDatabase () {
    //Finally close the connection pool.
    sql:ClientConnector.close(db_hermes_alert);
    
    system:println("Database Closed");
}

function insertTweet (int tweet_id, string tweet_text) {
    //Insert data using update action. If the DML statement execution
    //is success update action returns the updated row count.
    sql:Parameter[] params = [];
    sql:Parameter para1 = {sqlType:"integer", value:tweet_id};
    sql:Parameter para2 = {sqlType:"varchar", value:tweet_text};
    params = [para1, para2];
    int ret = sql:ClientConnector.update(db_hermes_alert, "Insert into tweet (tweet_id,tweet_text) values (?,?)", params);
    system:println("Inserted row count:" + ret);
}

function selectTweetByID (int tweet_id) {
    //Select data using select action. Select action returns a datatable
    //and see datatables section for more details on how to access data.
    sql:Parameter[] params = [];
    sql:Parameter para1 = {sqlType:"integer", value:tweet_id};
    params = [para1];
    datatable dt = sql:ClientConnector.select(db_hermes_alert, "SELECT * from tweet where tweet_id = ?", params);
    var jsonRes, err = <json>dt;
    system:println(jsonRes);
}
