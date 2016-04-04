exec = require('../util/exec')

module.exports = () ->
  exec('git reset --hard HEAD~')