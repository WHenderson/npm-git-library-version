exec = require('../util/exec')

module.exports = () ->
  exec('git status --porcelain')
  .then((out) ->
    if out.trim() != ''
      throw new Error("Working folder is not clean")

    return
  )
