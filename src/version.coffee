verifyChanges = require('./steps/verify-changes')
closeStdin = require('./steps/close-stdin')

module.exports = (argv) ->
  Promise.resolve()
  .then(() ->
    if not argv.ignoreChanges
      verifyChanges(argv.ignoreBower)
  )
  .catch((err) ->
    console.log(err)
  )
  .then(closeStdin, closeStdin)