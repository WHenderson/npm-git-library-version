verifyChanges = require('./steps/verify-changes')
readPackage = require('./steps/read-package')
syncVersion = require('./steps/sync-version')
commitChanges = require('./steps/commit-changes')
revertCommit = require('./steps/revert-commit')
reset = require('./steps/reset')
detach = require('./steps/detach')
reattach = require('./steps/reattach')
addFiles = require('./steps/add-files')
exec = require('./util/exec')

module.exports = (argv) ->
  pkg = null

  Promise.resolve()
  .then(() ->
    if not argv.ignoreChanges
      verifyChanges(argv.ignoreBower)
  )
  .then(() ->
    readPackage()
    .then((json) ->
      pkg = json

      if argv.files.length == 0 and pkg.files?
        argv.files = pkg.files.slice()
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
          if pkg.scripts.build?
            exec('npm run-script build')
            .then(() ->
              addFiles(argv.files)
            )
            .then(() ->
              exec('git clean -fd')
            )
        )
        .then(() ->
          exec('npm test')
        )
        .then(() ->
          if not pkg.scripts.build?
            addFiles(argv.files)
            .then(() ->
              exec('git clean -fd')
            )
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
