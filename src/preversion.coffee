verifyBranch = require('./steps/verify-branch')
verifyClean = require('./steps/verify-clean')

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
