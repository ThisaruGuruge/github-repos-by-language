# GitHub Repository Count by Language

This Ballerina program will print the count of GitHub repositories by language.

## Prerequisites

- Download and install [Ballerina](https://ballerina.io/downloads/)
- Create a GitHub personal access token. Follow the instructions in [Creating a personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) to create a personal access token.
- Create a `Config.toml` file in the root directory of the project and add the following configurations.

    ```toml
    token = "<GitHub Personal Access Token>"
    ```

- Run the program with the following command.

    ```bash
    bal run -- <language>
    ```
