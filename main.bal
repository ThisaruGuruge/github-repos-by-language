import ballerina/graphql;
import ballerina/http;
import ballerina/io;
import ballerina/os;

configurable string token = os:getEnv("packagePAT");

public function main(string language) returns error? {
    check getReposFromGraphql(language);
    check getReposFromRest(language);
}

isolated function getReposFromGraphql(string language) returns error? {
    graphql:Client github = check new ("https://api.github.com/graphql", {
        auth: {
            token
        }
    });

    string query = string `
        query {
            search(type: REPOSITORY, query: "language:${language}") {
                repositoryCount
            }
        }
    `;
    record {
        record {
            record {
                int repositoryCount;
            } search;
        } data;
    } response = check github->execute(query);
    io:println(string `No. of repos: ${response.data.search.repositoryCount}`);
}

isolated function getReposFromRest(string language) returns error? {
    http:Client githubClient = check new ("https://api.github.com", {
        auth: {
            token
        }
    });
    string query = string `q=language:${language}`;
    record {int total_count;} searchResult = check githubClient->get(string `/search/repositories?${query}`);
    io:println(string `No. of repos: ${searchResult.total_count}`);
}
