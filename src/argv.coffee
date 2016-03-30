argv = require('yargs')
.usage('Usage: $0 <command> [options]')
.command(
  'preversion',
  'To be run as part of your npm preversion script.',
  (yargs) ->
    yargs
    .epilog('''
      Does the following:

      1. Verifies head is <branch>
      2. Verifies working folder is not dirty

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
      Does the following:

      1. Verify expected (and only expected) files have been modified
      2. Syncronise package files
      3. Add package files
      4. Commit changes
      5. Add distribution files
      6. Commit distribution files
      7. Tag as a versioned release
      8. Publish
      9. Revert to original branch
      10. Push to origin with tags

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
    .option('ignore-unexpected-changes', {
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
    .options('dont-push', {
      demand: false
      default: false
      description: 'Do not push changes to origin'
      type: 'boolean'
    })
    .help('h')
)
.demand(1)
.strict()
.help('h')
.argv

module.exports = do ->
  if argv._[0] == 'version'
    argv.files = argv._.slice(1)

  return argv

console.log('argv:', module.exports)
