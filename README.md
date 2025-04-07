# GitHub Explore

This repository houses all of the community-curated content for GitHub Topics and Collections.

[Topics](https://help.github.com/articles/about-topics/) help you explore repositories in a particular subject area, learn more about that subject, and find projects to contribute to.

[Collections](https://github.com/collections) help you discover hand-picked repositories, developers, organizations, videos, and articles that share a common theme.

If you want to suggest edits to an existing Topic page or Collection, or curate a new one, read our [contributing guide](CONTRIBUTING.md) to get started. You can also [review a list of popular Topics that need more context](topics-todo.md) to get an idea of where to start.

## Running tests

There are some lint tests in place to ensure each Topic is formatted in the way we expect. GitHub
Actions will run the tests automatically. If you want to run the tests yourself locally, you will
need Ruby and Bundler installed.

You can run the tests using:

```bash
bundle installจ
bundle exec rubocop
```

## Licenses

Content is released under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/) which gives you permission to use content for almost any purpose (but does not grant you any trademark permissions). See [notices](notices.md) for complete details, including attribution guidelines, contribution terms, and software and third-party licenses and permissions.
:_<

tr4200812
explore

Code
Pull requests
1
Actions
Projects
Security
3
Insights
Settings
Settings: tr4200812/explore
Access
Code and automation
Security
Integrations
Runners / Add new self-hosted runner · tr4200812/explore
Adding a self-hosted runner requires that you download, configure, and execute the GitHub Actions Runner. If you do not already have an existing volume licensing agreement for your GitHub purchases, by downloading and configuring the GitHub Actions Runner, you agree to the GitHub Customer Agreement.

Runner image

macOS

Linux

Windows
Architecture
Download
We recommend configuring the runner under "\actions-runner". This will help avoid issues related to service identity folder permissions and long path restrictions on Windows.

# Create a folder under the drive root
$ mkdir actions-runner; cd actions-runner
# Download the latest runner package
$ Invoke-WebRequest -Uri https://github.com/actions/runner/releases/download/v2.323.0/actions-runner-win-x64-2.323.0.zip -OutFile actions-runner-win-x64-2.323.0.zip
Copied! # Optional: Validate the hash
$ if((Get-FileHash -Path actions-runner-win-x64-2.323.0.zip -Algorithm SHA256).Hash.ToUpper() -ne 'e8ca92e3b1b907cdcc0c94640f4c5b23f377743993a4a5c859cb74f3e6eb33ef'.ToUpper()){ throw 'Computed checksum did not match' }
Copied!# Extract the installer
$ Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory("$PWD/actions-runner-win-x64-2.323.0.zip", "$PWD")
Copied!
Configure
# Create the runner and start the configuration experience
$ ./config.cmd --url https://github.com/tr4200812/explore --token BK3ANBMPE3JAPEBYVGIOIGTH6PXEY
# Run it!
$ ./run.cmd
Using your self-hosted runner
# Use this YAML in your workflow file for each job
runs-on: self-hosted
For additional details about configuring, running, or shutting down the runner, please check out our product docs.
