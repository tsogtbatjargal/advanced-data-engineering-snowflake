USE ROLE accountadmin;
CREATE DATABASE course_repo;
USE SCHEMA public;

-- Create credentials
CREATE OR REPLACE SECRET course_repo.public.github_pat
  TYPE = password
  USERNAME = 'tsogtbatjargal' -- GitHub username
  PASSWORD = '{{GITHUB_PAT}}'; -- Use a placeholder or environment variable
  
-- Create the API integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = 'GIT_HTTPS_API'
  API_ALLOWED_PREFIXES = ('https://github.com/tsogtbatjargal') -- URL to your GitHub profile
  ALLOWED_AUTHENTICATION_SECRETS = (GITHUB_PAT) -- Name of the secret defined above
  ENABLED = TRUE;

-- Create the git repository object
CREATE OR REPLACE GIT REPOSITORY course_repo.public.advanced_data_engineering_snowflake
  API_INTEGRATION =  git_api_integration -- Name of the API integration defined above
  ORIGIN = 'https://github.com/tsogtbatjargal/advanced-data-engineering-snowflake.git' -- Insert URL of forked repo
  GIT_CREDENTIALS = course_repo.public.github_pat; -- Name of the secret defined above

-- List the git repositories
SHOW GIT REPOSITORIES;