verifyChanges = require('./steps/verify-changes')
readPackage = require('./steps/read-package')
syncVersion = require('./steps/sync-version')
closeStdin = require('./steps/close-stdin')

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
    syncVersion(pkg.version, argv.ignoreBower)
  )
  .catch((err) ->
    console.log(err)
  )
  .then(closeStdin, closeStdin)