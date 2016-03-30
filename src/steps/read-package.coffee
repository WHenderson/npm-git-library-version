exec = require('../util/exec')
stat = require('../util/stat')
readFile = require('../util/read-file')
writeFile = require('../util/write-file')

module.exports = (ignoreBower=false) ->
  readFile('package.json')
  .then((data) ->
    JSON.parse(data.toString())
  )
