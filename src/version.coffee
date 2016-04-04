verifyChanges = require('./steps/verify-changes')
readPackage = require('./steps/read-package')
syncVersion = require('./steps/sync-version')
commitChanges = require('./steps/commit-changes')
closeStdin = require('./steps/close-stdin')
revertCommit = require('./steps/revert-commit')
reset = require('./steps/reset')
detach = require('./steps/detach')
reattach = require('./steps/reattach')

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
      .then(
        () ->
          reattach(argv.branch)
        (err) ->
          reattach(argv.branch)
          .then((err) ->
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
