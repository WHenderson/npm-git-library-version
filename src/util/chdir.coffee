process = require('process')

module.exports = (path) ->
  Promise.resolve()
  .then(() ->
    process.chdir(path)
  )
