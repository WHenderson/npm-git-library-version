exec = require('../util/exec')

module.exports = (branch) ->
  exec("git checkout #{branch}")
