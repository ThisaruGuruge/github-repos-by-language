import ballerina/graphql;
import ballerina/io;
import ballerina/os;

configurable string token = os:getEnv("packagePAT");

configurable string language = os:getEnv("language");
configurable string createdBefore = os:getEnv("createdBefore");

public function main() returns error? {
    string query = string `language:${language}`;
    io:println(string `Counting repos for language: ${language}`);

    if createdBefore != "" {
        query = string `${query} created:<${createdBefore}`;
        io:println(string `Filtering repositories created before: ${createdBefore}`);
    } else {
        io:println(string `Counting all the repos without any date filter`);
    }
    check getReposFromGraphql(query);
}

const QUERY = string `
    query GetRepositoryCount($query: String!) {
        search(type: REPOSITORY, query: $query) {
            repositoryCount
        }
    }
`;

isolated function getReposFromGraphql(string query) returns error? {
    graphql:Client github = check new ("https://api.github.com/graphql", {
        auth: {
            token
        }
    });

    map<string> variables = {
        query
    };

    record {
        record {
            record {
                int repositoryCount;
            } search;
        } data;
    } response = check github->execute(QUERY, variables);
    io:println(string `No. of repos: ${response.data.search.repositoryCount}`);
}
