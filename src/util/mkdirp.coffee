mkdirp = require('mkdirp')

module.exports = () ->
  args = arguments
  new Promise((resolve, reject) ->
    mkdirp(args..., (err) ->
      if err?
        return reject(err)

      return resolve()
    )
    return
  )
