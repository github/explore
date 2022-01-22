# Ruby
# GH_TOKEN **(in order of precedence): an authentication token for github.com API requests. Setting this avoids being prompted to authenticate and takes precedence over previously stored credentials.)**

# CI Configuration
Run semantic-release only after all tests succeeded
The semantic-release command must be executed only after all the tests in the CI build pass. If the build runs multiple jobs (for example to test on multiple Operating Systems or Node versions)
the CI has to be configured to guarantee that the semantic-release command is executed only after all jobs are successful. Here is a few example of the CI services that can be used to achieve this:
​​
# Authentication
**Push access to the remote repository
semantic-release requires push access to the project Git repository in order to create Git tags. The Git authentication can be set with one of the following environment variables:
See each plugin's documentation for the environment variables required.
The authentication token/credentials have to be made available in the CI service via environment variables.
See  for more details on how to configure environment variables in your CI service.
Note: The environment variables GH_TOKEN, GITHUB_TOKEN, GL_TOKEN and GITLAB_TOKEN can be used for both the Git authentication and the API authentication required by  and .

# RubyGems-1.0.0.gem

**Download RubyGems v3.3.5 - January 12, 2022
RubyGems is a package management framework for Ruby. 
to upgrade to the latest RubyGems:

$ gem update --system
You might be running into some bug that prevents you from upgrading rubygems the standard way. In that case, you can try upgrading manually:

Download from above
**Unpack into a directory and cd there
Install with: ruby setup.rb**

Community-curated topic and collection pages on GitHub

#RubyGems
