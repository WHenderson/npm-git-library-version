exec = require('../util/exec')

module.exports = (files) ->
  console.log('add files:', files)
  add = Promise.resolve()

  if files?
    for fileName in files
      do (fileName) ->
        add = add.then(() ->
          exec("git add -f #{fileName}")
        )

  return add

