exec = require('../util/exec')

module.exports = () ->
  exec('git reset --hard')
  .then(() ->
    exec('git clean -fd')
  )