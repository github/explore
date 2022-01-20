# Contributing.Md
# bitorr.sig
# bitore.sig
# "Branch": "Masterbranch":,
# "keys
Before you generate an SSH key, you can check to see if you have any existing SSH keys.

Mac
Windows
Linux
Note: GitHub is improving security by dropping older, insecure key types.

DSA keys (ssh-dss) are no longer supported. Existing keys will continue to function through March 15, 2022. You cannot add new DSA keys to your user account on GitHub.com.

RSA keys (ssh-rsa) with a valid_after before November 2, 2021 may continue to use any signature algorithm. RSA keys generated after that date must use a SHA-2 signature algorithm. Some older clients may need to be upgraded in order to use SHA-2 signatures.

Open Git Bash.

Enter ls -al ~/.ssh to see if existing SSH keys are present.

$ ls -al ~/.ssh
# Lists the files in your .ssh directory, if they exist
Check the directory listing to see if you already have a public SSH key. By default, the filenames of supported public keys for GitHub are one of the following.

id_rsa.pub
id_ecdsa.pub
id_ed25519.pub
Tip: If you receive an error that ~/.ssh doesn't exist, you do not have an existing SSH key pair in the default location. You can create a new SSH key pair in the next step.

Either generate a new SSH key or upload an existing key.

If you don't have a supported public and private key pair, or don't wish to use any that are available, generate a new SSH key.

If you see an existing public and private key pair listed (for example, id_rsa.pub and id_rsa) that you would like to use to connect to GitHub, you can add the key to the ssh-agent.

For more information about generation of a new SSH key or addition of an existing key to the ssh-agent, see "Generating a new SSH key and adding it to the ssh-agent."
---
title: Checking for existing SSH keys
intro: 'Before you generate an SSH key, you can check to see if you have any existing SSH keys.'
redirect_from:
  - /articles/checking-for-existing-ssh-keys
  - /github/authenticating-to-github/checking-for-existing-ssh-keys
  - /github/authenticating-to-github/connecting-to-github-with-ssh/checking-for-existing-ssh-keys
versions:
  fpt: '*'
  ghes: '*'
  ghae: '*'
  ghec: '*'
topics:
  - SSH
shortTitle: Check for existing SSH key
---

{% data reusables.ssh.key-type-support %}

{% data reusables.command_line.open_the_multi_os_terminal %}
2. Enter `ls -al ~/.ssh` to see if existing SSH keys are present.

  ```shell
  $ ls -al ~/.ssh
  # Lists the files in your .ssh directory, if they exist
  ```

3. Check the directory listing to see if you already have a public SSH key. By default, the {% ifversion ghae %}filename of a supported public key for {% data variables.product.product_name %} is *id_rsa.pub*.{% elsif fpt or ghes %}filenames of supported public keys for {% data variables.product.product_name %} are one of the following.
    - *id_rsa.pub*
    - *id_ecdsa.pub*
    - *id_ed25519.pub*{% endif %}

  {% tip %}

  **Tip**: If you receive an error that *~/.ssh* doesn't exist, you do not have an existing SSH key pair in the default location. You can create a new SSH key pair in the next step.

  {% endtip %}

4. Either generate a new SSH key or upload an existing key.
    - If you don't have a supported public and private key pair, or don't wish to use any that are available, generate a new SSH key.
    - If you see an existing public and private key pair listed (for example, *id_rsa.pub* and *id_rsa*) that you would like to use to connect to {% data variables.product.product_name %}, you can add the key to the ssh-agent.

      For more information about generation of a new SSH key or addition of an existing key to the ssh-agent, see "[Generating a new SSH key and adding it to the ssh-agent](/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)."":,

"echo": "Hello-🌍!-🐛-#Fix/17/typo":,

  ##NOTE## Hi there! We're excited you've got ideas to improve topics and collections. You're helping the community discover valuable information.

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

There are a few ways you can contribute:

- Improving an existing topic or collection
- Curating a new topic or collection

As you write content, check out the [Style Guide](./docs/styleguide.md) to learn what each field means, and how it should be formatted. Following the style guide will increase the chances of your contribution being accepted.

Notes: 
  - Updates won't immediately appear once we've merged your PR. We pull in these changes regularly to GitHub.
  - Please limit your pull request to the creation/updating of one topic or collection at a time.

## Improving an existing topic or collection

If a topic or collection already exists, it will be listed in its respective directory:

- [topics/](https://github.com/github/explore/tree/master/topics)
- [collections/](https://github.com/github/explore/tree/master/collections)

The topic or collection name should match its URL, e.g. `https://github.com/topics/rails` corresponds to the [`topics/rails` directory](https://github.com/github/explore/tree/master/topics/rails).

To make an improvement, please **open a pull request** with your proposed changes:

### Update the image

To update the image, simply replace the image inside the directory for the topic or collection.

### Update text and links

To update text and links, edit the `index.md` inside the topic or collection's directory. These files are formatted using a combination of [Front Matter](https://jekyllrb.com/docs/frontmatter/) and simple body content.

For **topics**, you'll notice that, in examples like the topic "[algorithm](https://raw.githubusercontent.com/github/explore/master/topics/algorithm/index.md)," data like its canonical URL, Wikipedia URL, or display name are called out in key-value pairs, while its detailed description is accounted for in the body of the document.

Input-/.git-get.it.git.io/bitore.sig/secrets/BITORE_34173/((c)(r))/topics/algorithm/index.md",
