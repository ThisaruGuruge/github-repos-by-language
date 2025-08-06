import ballerina/graphql;
import ballerina/io;
import ballerina/os;

configurable string token = os:getEnv("packagePAT");

configurable string language = os:getEnv("language");
configurable string createdBefore = os:getEnv("createdBefore");

public function main() returns error? {
    check getReposFromGraphql(language, createdBefore);
}

const QUERY = string `
    query GetRepositoryCount($query: String!) {
        search(type: REPOSITORY, query: $query) {
            repositoryCount
        }
    }
`;

isolated function getReposFromGraphql(string language, string createdBefore) returns error? {
    graphql:Client github = check new ("https://api.github.com/graphql", {
        auth: {
            token
        }
    });

    map<string> variables = {
        "query": string `language:${language} created:<${createdBefore}`
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
