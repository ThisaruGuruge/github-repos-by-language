# GitHub Repository Count by Language

This Ballerina program counts GitHub repositories by language using the GitHub GraphQL API.

## Features

- Count repositories by programming language
- Filter by creation date
- Support for both local execution and GitHub Actions
- Uses GitHub GraphQL API for efficient data retrieval

## Prerequisites

- Download and install [Ballerina](https://ballerina.io/downloads/) (version 2201.8.0 or later)
- GitHub personal access token with appropriate permissions

## Configuration

### For GitHub Actions
The application uses environment variables for configuration:

- `packagePAT`: Your GitHub personal access token
- `language`: The programming language to search for (e.g., "ballerina", "python", "javascript")
- `createdBefore`: Date filter in format `YYYY-MM-DD` (optional, defaults to current date)

### For Local Execution
Create a `Config.toml` file in the root directory of the project with the following configuration:

```toml
token = "<GitHub Personal Access Token>"
language = "<programming language>"
createdBefore = "<YYYY-MM-DD>"  # Optional, defaults to current date
```

## Running the Application

### Option 1: Using GitHub Actions (Recommended)

1. Fork this repository
2. Add your GitHub personal access token as a repository secret:
   - Go to your repository settings
   - Navigate to "Secrets and variables" → "Actions"
   - Add a new secret named `packagePAT` with your GitHub token
3. Go to the "Actions" tab in your repository
4. Select "Count the Number of Repos" workflow
5. Click "Run workflow"
6. Enter the language you want to search for (defaults to "ballerina")
7. Optionally enter a date in `YYYY-MM-DD` format to filter repositories created before that date
8. Click "Run workflow"

### Option 2: Running Locally

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd github-stats
   ```

2. Create a `Config.toml` file in the root directory:
   ```toml
   token = "your-github-personal-access-token"
   language = "ballerina"
   createdBefore = "2024-01-01"  # Optional
   ```

3. Run the program:
   ```bash
   bal run
   ```

## Output

The program will output the count of repositories in the following format:
```
No. of repos: <count>
```

## Example Usage

- Count all Ballerina repositories: Set `language=ballerina`
- Count Python repositories created before 2023: Set `language=python` and `createdBefore=2023-01-01`
- Count JavaScript repositories: Set `language=javascript`

## Creating a GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token (classic)"
3. Give it a descriptive name
4. Select the following scopes:
   - `public_repo` (for public repositories)
   - `repo` (for private repositories, if needed)
5. Click "Generate token"
6. Copy the token and use it as the `token` value in your `Config.toml` file

## Dependencies

- Ballerina GraphQL client for API communication
- Ballerina IO for console output
- Ballerina OS for environment variable access
