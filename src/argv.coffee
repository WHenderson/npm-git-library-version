module.exports = require('yargs')
.usage('Usage: $0 <command> [options]')
.command(
  'preversion',
  'To be run as part of your npm preversion script',
  (yargs) ->
    yargs
    .epilog('''
      Does the following:

      * Verifies head is <branch>
      * Verifies working folder is not dirty

      Exit code is non-zero on error.
    ''')
    .option('b', {
      alias: 'branch'
      demand: false
      default: 'master'
      describe: 'Set the expected branch name'
      type: 'string'
    })
    .option('ignore-branch', {
      demand: false
      default: false
      describe: 'Skip branch name verification'
      type: 'boolean'
    })
    .option('ignore-dirty', {
      demand: false
      default: false
      describe: 'Skip clean working folder verification'
      type: 'boolean'
    })
    .help('h')
)
.command(
  'version',
  'To be run as part of your npm version script',
  (yargs) ->
    yargs
    .usage('Usage: $0 version [options] [files...]')
    .epilog('''
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
    ''')
    .option('b', {
      alias: 'branch'
      demand: false
      default: 'master'
      describe: 'Set the expected branch name'
      type: 'string'
    })
    .option('ignore-changes', {
      demand: false
      default: false
      description: 'Ignore any unexpected file changes'
      type: 'boolean'
    })
    .option('ignore-bower', {
      demand: false
      default: false
      description: 'Do not syncronise/add bower.json'
      type: 'boolean'
    })
    .options('dont-sync', {
      demand: false
      default: false
      description: 'Do not syncronise version across package files'
      type: 'boolean'
    })
    .options('dont-commit-version', {
      demand: false
      default: false
      description: 'Do not commit version changes'
      type: 'boolean'
    })
    .options('dont-push', {
      demand: false
      default: false
      description: 'Do not push changes to origin'
      type: 'boolean'
    })
    .help('h')
)
.command(
  'postversion',
  'To be run as part of your npm postversion script',
  (yargs) ->
    yargs
    .usage('Usage: $0 postversion [options]')
    .epilog('''
      Does the following:

      * Verifies head is <branch>
      * Verifies working folder is not dirty
      * Verifies current version is tagged
      * git push / git push --tags
      * Checkout version tag
      * npm publish
      * Revert to branch

      Exit code is non-zero on error.
    ''')
    .option('b', {
      alias: 'branch'
      demand: false
      default: 'master'
      describe: 'Set the expected branch name'
      type: 'string'
    })
    .option('ignore-branch', {
      demand: false
      default: false
      describe: 'Skip branch name verification'
      type: 'boolean'
    })
    .option('ignore-dirty', {
      demand: false
      default: false
      describe: 'Skip clean working folder verification'
      type: 'boolean'
    })
    .option('no-git-push', {
      demand: false
      default: false
      describe: 'Do not push changes'
      type: 'boolean'
    })
    .option('no-npm-publish', {
      demand: false
      default: false
      describe: 'Do not publish to npm'
      type: 'boolean'
    })
    .help('h')
)
.demand(1)
.strict()
.help('h')
