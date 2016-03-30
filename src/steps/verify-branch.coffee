exec = require('../util/exec')

module.exports = (branch) ->
  exec('git rev-parse --abbrev-ref HEAD')
  .then((out) ->
    if out.trim() != branch
      throw new Error("HEAD is not \"#{branch}\"")

    return
  )
