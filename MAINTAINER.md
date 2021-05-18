## Maintainer Notes

If you are reading this, you probably forgot how to release a new version. Keep
reading.

### Making a new release

1. Start your git flow workflow:

        git flow init

2. Create a new milestone in GitHub. Plan the features of your new release. Assign
existing bugs to your new milestone.
3. Start a new feature:

        git flow feature start <feature name>

4. Code, code and code. More coding. Fuck it up several times. Push to feature
branch. Watch Travis go red. Write unit tests. Watch Travis go red again. Don't
leave uncommitted changes.
5. Finish your feature:

        git flow feature finish <feature name>

6. Repeat 3-5 for every other feature you have planned for this release.
7. When you're done with the features and ready to publish, start a new release:

        git flow release start <release number>

8. Bump your version:

        bumpversion --no-commit --new-version <release number> patch

9. Update your changelog:

        gitchangelog > HISTORY.md

10. Commit your changes to version files and changelog:

        git commit -aS -m "Updating Changelog and version."

11. Delete the tag made by bumpversion:

        git tag -d <release number>

12. Finish your release:

        git flow release finish -s -p <release number>

13. Push your tags:

        git push --tags

14. Draft a new release in GitHub (based on the new version tag) and include
a description. Also pick a codename because it makes you cool.
15. Close the milestone in GitHub.
16. Write about your new version in your blog. Tweet it, post it on facebook.

### Making a new hotfix

1. Create a new milestone in GitHub. Assign existing bugs to your new milestone.
2. Start a new hotfix:

        git flow hotfix start <new version>

3. Code your hotfix.
4. Bump your version:

        bumpversion --no-commit --new-version <new version> patch

5. Update your changelog:

        gitchangelog > HISTORY.md

6. Commit your changes to version files and changelog:

        git commit -aS -m "Updating Changelog and version."

7. Delete the tag made by bumpversion:

        git tag -d <new version>

8. Finish your hotfix:

        git flow hotfix finish -s -p <new version>

9. Push your tags:

        git push --tags

10. Draft a new release in GitHub (based on the new version tag) and include
a description. Don't change the codename if it is a hotfix.
11. Close the milestone in GitHub.
12. Write about your new version in your blog. Tweet it, post it on facebook.
