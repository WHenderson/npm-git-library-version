verifyBranch = require('./steps/verify-branch')
verifyClean = require('./steps/verify-clean')
closeStdin = require('./steps/close-stdin')
reattach = require('./steps/reattach')
exec = require('./util/exec')

module.exports = (argv) ->
  pkg = null

  Promise.resolve()
  .then(() ->
    if not argv.ignoreBranch
      verifyBranch(argv.branch)
  )
  .then(() ->
    if not argv.ignoreDirty
      verifyClean()
  )
  .then(() ->
    readPackage()
    .then((json) ->
      pkg = json
    )
  )
  .then(() ->
    Promise.resolve()
    .then(() ->
      exec("git checkout v#{pkg.version}")
    )
    .then(() ->
      Promise.resolve()
      .then(() ->
        if not argv.noGitPush
          exec('git push')
      )
      .then(() ->
        if not argv.noGitPush
          exec('git push --tags')
      )
      .then(() ->
        if not argv.noNpmPublish
          exec('npm publish')
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
