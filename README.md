# npm-git-library-version
Scripts for versioning a library through npm and git.

This library is targeted at modules which want to check built files into releases without placing them under primary source control.
Works with npm and, optionally, bower. 

## Installation
```
npm install --save-dev npm-git-library-version
```

## Usage

1. Place the following commands into your package.json
```json
{
  "files": [
    "if the files key exists in your package.json, it is used as the default list of files to add to git before distribution"
  ],
  "scripts": {
    "preversion": "npm-git-library-version preversion",
    "version": "npm-git-library-version version",
    "postversion": "npm-git-library-version postversion",
    "build": "echo \"Optional build script. Will be run to generate any files required for distribution\" && exit 0",
    "test": "echo \"Required testing script. If no build script is provided, this is expected to build the package before testing\" && exit 0"
  }
}
```

2. Ensure you have a `.npmrc` file alongside your package .json with the following content
```
git-tag-version=false
```

##  Commandline
```
Usage: npm-git-library-version <command> [options]
                       
Commands:
  preversion   To be run as part of your npm preversion script.
               Verifies git is on the master branch and is clean
  version      To be run as part of your npm version script.
               Builds, Validates, Commits and Tags the package.
  postversion  To be run as part of your npm postversion script.
               Verifies git state and structure then pushes changes and publishes to npm.

Options:
 -h  Show help                                                        [boolean]
```

## preversion
```
Usage: npm-git-library-version preversion [options]

Options:
  -h               Show help  [boolean]
  -b, --branch     Set the expected branch name  [string] [default: "master"]
  --ignore-branch  Skip branch name verification  [boolean] [default: false]
  --ignore-dirty   Skip clean working folder verification  [boolean] [default: false]

Does the following:

* Verifies head is <branch>
* Verifies working folder is not dirty

Exit code is non-zero on error.
```

## version
```
Usage: npm-git-library-version version [options] [files...]

Options:
  -h                     Show help  [boolean]
  -b, --branch           Set the expected branch name  [string] [default: "master"]
  --ignore-changes       Ignore any unexpected file changes  [boolean] [default: false]
  --ignore-bower         Do not syncronise/add bower.json  [boolean] [default: false]
  --dont-sync            Do not syncronise version across package files  [boolean] [default: false]
  --dont-commit-version  Do not commit version changes  [boolean] [default: false]
  --dont-push            Do not push changes to origin  [boolean] [default: false]

Notes:
  [files...] defaults to those provided in package.json

Does the following:

* Verify expected (and only expected) files have been modified
* Syncronise package files
* Add package files
* Commit changes
* Build (npm run-script build), if required
* Test (npm test)
* Add distribution files
* Commit distribution files
* Tag as a versioned release
* Publish
* Revert to original branch
* Push to origin with tags

Exit code is non-zero on error.

Workging folder is reset/cleaned on error.
```


## postversion
```
Usage: npm-git-library-version postversion [options]

Options:
  -h                Show help  [boolean]
  -b, --branch      Set the expected branch name  [string] [default: "master"]
  --ignore-branch   Skip branch name verification  [boolean] [default: false]
  --ignore-dirty    Skip clean working folder verification  [boolean] [default: false]
  --no-git-push     Do not push changes  [boolean] [default: false]
  --no-npm-publish  Do not publish to npm  [boolean] [default: false]

Does the following:

* Verifies head is <branch>
* Verifies working folder is not dirty
* Verifies current version is tagged
* git push / git push --tags
* Checkout version tag
* npm publish
* Revert to branch

Exit code is non-zero on error.
```