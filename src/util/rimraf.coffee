rimraf = require('rimraf')

module.exports = (arguments) ->
  new Promise((resolve, reject) ->
    rimraf(arguments..., (err) ->
      if err?
        return reject(err)

      return resolve()
    )
    return
  )
