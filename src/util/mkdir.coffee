mkdirp = require('mkdirp')

module.exports = (arguments) ->
  new Promise((resolve, reject) ->
    mkdirp(arguments..., (err) ->
      if err?
        return reject(err)

      return resolve()
    )
    return
  )
