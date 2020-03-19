# Semantic versioning for use with Gitlab CI/CD

This libs is used to versioning your app with [semantic-versioning](https://semver.org/) rules

You can contribute to this libs by create issues or a pull request.

Docker images: https://hub.docker.com/repository/docker/dennbagas/win-semver

## How to use

- Create a [Gitlab Personal Access Tokens](https://gitlab.com/profile/personal_access_tokens) with API scopes. Read more about Gitlab Personal Access Token [here](https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html)
- Add variable with the name **"GL_TOKEN"** in your gitlab setting with the value of your access token
- Create a `.gitlab-ci.yml` file in your app root folder. Read `.gitlab-ci-example.yml`

## Bump version

Main feature of this libs is to provide version bump automatically by reading the latest commit message and compare it with latest git tag. Your commit message must contain:

```
"[patch]" to trigger PATCH number bump. eg v1.0.0 -> v1.0.1
"[minor]" to trigger MINOR number bump. eg v1.3.8 -> v1.4.0
"[major]" to trigger MAJOR number bump. eg v1.6.3 -> v2.0.0
```

When you have a multiple environment, you can bump with flag `--build-level "dev"` this will search latest tag with `"dev"` string eg: 1.0.0-dev

## Push tag back

This libs can push back tag to repository with the command: `win push-tag "tag-name"`. This will create new tag in your repository. You can auto delete the last tag with flag: `--delete-old-tag "old-tag-name"`

## All Usage

```
win bump (--build-level <dev|prod|anything>)
win get-latest-tag <search-tag-value> (optional)
win analyze-commit
win push-tag <tag> (--delete-old-tag <old tag>)
win --help
win --version

Commands:
<bump> Trigger bump version automatically (patch|major|minor) analyzing commit message

<get-latest-tag>  Get latest tag from gitlab

<analyze-commit>  Detect a commit message that trigger bumping level.
                  A commit message must contain the following string:
                    -- \"[patch]\" to trigger PATCH number bump
                    -- \"[minor]\" to trigger MINOR number bump
                    -- \"[major]\" to trigger MAJOR number bump

<push-tag>        Push tag back to gitlab

Options:
-v, --version Print the version of this tool.
-h, --help Print this help message."
```

### Because this libs use semver-tool, you can use semver-tool api:

```
semver bump (major|minor|patch|release|prerel <prerel>|build <build>) <version>
semver compare <version> <other_version>
semver get (major|minor|patch|release|prerel|build) <version>
semver --help
semver --version

Arguments:
<version>       A version must match the following regular expression:
                "^[vV]
                 ?(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)
                 (\-(0|[1-9][0-9]*|[0-9]*[A-Za-z-][0-9A-Za-z-]*)(\.(0|[1-9][0-9]*|[0-9]*[A-Za-z-][0-9A-Za-z-]*))*)
                 ?(\+[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?$"
                In English:
                -- The version must match X.Y.Z[-PRERELEASE][+build] where X, Y and Z are non-negative integers.
                -- PRERELEASE is a dot separated sequence of non-negative integers and/or identifiers composed of
                   alphanumeric characters and hyphens (with at least one non-digit).
                   Numeric identifiers must not have leading zeros. A hyphen (\"-\") introduces this optional part.
                -- BUILD is a dot separated sequence of identifiers composed of alphanumeric characters and hyphens.
                   A plus (\"+\") introduces this optional part.

<other_version> See <version> definition.

<prerel>        A string as defined by PRERELEASE above.

<build>         A string as defined by BUILD above.

Options:
-v, --version Print the version of this tool.
-h, --help Print this help message.

Commands:
<bump>      Bump by one of major, minor, patch; zeroing or removing
            subsequent parts. \"bump prerel\" sets the PRERELEASE part and
            removes any BUILD part. \"bump build\" sets the BUILD part.
            \"bump release\" removes any PRERELEASE or BUILD parts.
            The bumped version is written to stdout.

<compare>   Compare <version> with <other_version>, output to stdout the
            following values: -1 if <other_version> is newer, 0 if equal, 1 if
            older. The BUILD part is not used in comparisons.

<get>       Extract given part of <version>, where part is one of major, minor,
            patch, prerel, build, or release.
```

See also:
https://semver.org -- Semantic Versioning 2.0.0
