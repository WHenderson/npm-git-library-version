module.exports = require('yargs').usage('Usage: $0 <command> [options]').command('preversion', 'To be run as part of your npm preversion script.\nVerifies git is on the master branch and is clean', function(yargs) {
  return yargs.usage('Usage: $0 preversion [options]').epilog('Does the following:\n\n* Verifies head is <branch>\n* Verifies working folder is not dirty\n\nExit code is non-zero on error.').option('b', {
    alias: 'branch',
    demand: false,
    "default": 'master',
    describe: 'Set the expected branch name',
    type: 'string'
  }).option('ignore-branch', {
    demand: false,
    "default": false,
    describe: 'Skip branch name verification',
    type: 'boolean'
  }).option('ignore-dirty', {
    demand: false,
    "default": false,
    describe: 'Skip clean working folder verification',
    type: 'boolean'
  }).help('h');
}).command('version', 'To be run as part of your npm version script.\nBuilds, Validates, Commits and Tags the package.', function(yargs) {
  return yargs.usage('Usage: $0 version [options] [files...]').epilog('Notes:\n  [files...] defaults to those provided in package.json\n\nDoes the following:\n\n* Verify expected (and only expected) files have been modified\n* Syncronise package files\n* Add package files\n* Commit changes\n* Build (npm run-script build), if required\n* Test (npm test)\n* Add distribution files\n* Commit distribution files\n* Tag as a versioned release\n* Publish\n* Revert to original branch\n* Push to origin with tags\n\nExit code is non-zero on error.\n\nWorkging folder is reset/cleaned on error.').option('b', {
    alias: 'branch',
    demand: false,
    "default": 'master',
    describe: 'Set the expected branch name',
    type: 'string'
  }).option('ignore-changes', {
    demand: false,
    "default": false,
    description: 'Ignore any unexpected file changes',
    type: 'boolean'
  }).option('ignore-bower', {
    demand: false,
    "default": false,
    description: 'Do not syncronise/add bower.json',
    type: 'boolean'
  }).options('dont-sync', {
    demand: false,
    "default": false,
    description: 'Do not syncronise version across package files',
    type: 'boolean'
  }).options('dont-commit-version', {
    demand: false,
    "default": false,
    description: 'Do not commit version changes',
    type: 'boolean'
  }).options('dont-push', {
    demand: false,
    "default": false,
    description: 'Do not push changes to origin',
    type: 'boolean'
  }).help('h');
}).command('postversion', 'To be run as part of your npm postversion script.\nVerifies git state and structure then pushes changes and publishes to npm.', function(yargs) {
  return yargs.usage('Usage: $0 postversion [options]').epilog('Does the following:\n\n* Verifies head is <branch>\n* Verifies working folder is not dirty\n* Verifies current version is tagged\n* git push / git push --tags\n* Checkout version tag\n* npm publish\n* Revert to branch\n\nExit code is non-zero on error.').option('b', {
    alias: 'branch',
    demand: false,
    "default": 'master',
    describe: 'Set the expected branch name',
    type: 'string'
  }).option('ignore-branch', {
    demand: false,
    "default": false,
    describe: 'Skip branch name verification',
    type: 'boolean'
  }).option('ignore-dirty', {
    demand: false,
    "default": false,
    describe: 'Skip clean working folder verification',
    type: 'boolean'
  }).option('no-git-push', {
    demand: false,
    "default": false,
    describe: 'Do not push changes',
    type: 'boolean'
  }).option('no-npm-publish', {
    demand: false,
    "default": false,
    describe: 'Do not publish to npm',
    type: 'boolean'
  }).help('h');
}).demand(1).strict().help('h');
