exec = require('../util/exec')
stat = require('../util/stat')
readFile = require('../util/read-file')
writeFile = require('../util/write-file')

module.exports = (version, ignoreBower=false) ->
  Promise.resolve()
  .then(() ->
    if not ignoreBower
      stat('bower.json')
      .then(
        () ->
          readFile('bower.json')
          .then((data) ->
            JSON.parse(data.toString())
          )
          .then((json) ->
            json.version = version
            writeFile('bower.json', JSON.stringify(json, null, 2))
          )
        (err) ->
          if err.code == 'ENOENT'
            return
          throw err
      )

  )