import ballerina/http;

type Account readonly & record {|
    string accountNumber;
    string accountName;
    float balance;
    string currency;
|};

table<Account> key(accountNumber) accounts = table [
    {accountNumber: "12345", accountName: "John's Account", balance: 1000.0, currency: "USD"}
];

service /accounts on new http:Listener(9090) {

    resource function post . (@http:Payload Account account) returns Account {
        accounts.add(account);
        return account;
    }

    resource function get [string accountNumber]() returns Account {
        return accounts.get(accountNumber);
    }

    
}
