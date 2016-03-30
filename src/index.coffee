verifyBranch = require('./steps/verify-branch')
verifyClean = require('./steps/verify-clean')
closeStdin = require('./steps/close-stdin')

Promise.resolve()
.then(() ->

)
.then(verifyBranch('master'))
.then(verifyClean())
.catch((err) ->
  console.log(err)
)
.then(closeStdin, closeStdin)