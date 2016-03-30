exec = require('../util/exec')
readFile = require('../util/read-file')

module.exports = (ignoreBower=false) ->
  readFile('package.json')
  .then((data) ->
    JSON.parse(data.toString())
  )
