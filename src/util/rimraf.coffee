rimraf = require('rimraf')

module.exports = () ->
  args = arguments
  new Promise((resolve, reject) ->
    rimraf(args..., (err) ->
      if err?
        return reject(err)

      return resolve()
    )
    return
  )
