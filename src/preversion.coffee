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
  .catch((err) ->
    console.log(err)
  )
  .then(closeStdin, closeStdin)