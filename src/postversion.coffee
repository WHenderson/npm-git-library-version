verifyBranch = require('./steps/verify-branch')
verifyClean = require('./steps/verify-clean')
closeStdin = require('./steps/close-stdin')

module.exports = (argv) ->
  Promise.resolve()
  .then(() ->
    if not argv.ignoreBranch
      verifyBranch(argv.branch)
  )
  .then(() ->
    if not argv.ignoreDirty
      verifyClean()
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
