exec = require('../util/exec')
stat = require('../util/stat')

module.exports = (version, ignoreBower=false) ->

  expected = [
    'package.json'
    'npm-shrinkwrap.json'
  ]
  if not ignoreBower
    expected.push('bower.json')
    
  promise = Promise.resolve()
  
  for name in expected
    do (name) ->
      promise = promise.then(() ->
        stat(name)
        .then(
          () ->
            exec("git add #{name}")
          (err) ->
            if err.code == 'ENOENT'
              return
            throw err
        )
      )

  promise
  .then(() ->
    exec("git commit -m \"v#{version}\"")
    .then(() ->
      # ToDo: Handle cleanup
    )
  )