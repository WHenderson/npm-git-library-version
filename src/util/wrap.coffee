module.exports = (func) ->
  () ->
    args = arguments
    new Promise((resolve, reject) ->
      func(args..., (err, result) ->
        if err?
          return reject(err)

        resolve(result)
        return
      )
      return
    )
