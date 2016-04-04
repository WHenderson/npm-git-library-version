verifyChanges = require('./steps/verify-changes')
readPackage = require('./steps/read-package')
syncVersion = require('./steps/sync-version')
commitChanges = require('./steps/commit-changes')
closeStdin = require('./steps/close-stdin')
revertCommit = require('./steps/revert-commit')
reset = require('./steps/reset')
detach = require('./steps/detach')
reattach = require('./steps/reattach')
exec = require('./util/exec')

module.exports = (argv) ->
  pkg = null

  Promise.resolve()
  .then(() ->
    if not argv.ignoreChanges
      verifyChanges(argv.ignoreBower)
  )
  .then(() ->
    readPackage(argv.ignoreBower)
    .then((json) ->
      pkg = json
    )
  )
  .then(() ->
    Promise.resolve()
    .then(() ->
      if not argv.dontSync
        syncVersion(pkg.version, argv.ignoreBower)
    )
    .then(() ->
      if not argv.dontCommitVersionChanges
        commitChanges(pkg.version, argv.ignoreBower)
    )
    .then(() ->
      Promise.resolve()
      .then(() ->
        detach()
      )
      .then(() ->
        Promise.resolve()
        .then(() ->
          exec('npm run-script build')
        )
        .then(() ->
          add = Promise.resolve()
          for fileName in argv.files
            do (fileName) ->
              add = add.then(() ->
                exec("git add -f #{fileName}")
              )
          return add
        )
        .then(() ->
          exec('git clean -fd')
        )
        .then(() ->
          exec('npm test')
        )
        .then(() ->
          exec('git commit -m "distribution files"')
        )
        .then(() ->
          exec("git tag -a \"v#{pkg.version}\" -m \"v#{pkg.version} for distribution\"")
        )
      )
      .then(
        () ->
          reattach(argv.branch)
        (err) ->
          reattach(argv.branch)
          .then(() ->
            throw err
          )
      )
    )
    .catch((err) ->
      if not argv.dontCommitVersionChanges
        revertCommit()
        .then(() ->
          throw err
        )
      else
        throw err
    )
  )
  .catch((err) ->
    reset()
    .then(() ->
      throw err
    )
  )
  .then(closeStdin, closeStdin)
  .then(
    () ->
      process.exit(0)

    (err) ->
      console.error('Operation failed.')
      console.error(err)
      process.exit(-1)
  )
