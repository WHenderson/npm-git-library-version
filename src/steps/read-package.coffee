exec = require('../util/exec')
readFile = require('../util/read-file')

module.exports = () ->
  readFile('package.json')
  .then((data) ->
    JSON.parse(data.toString())
  )
