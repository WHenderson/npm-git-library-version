process = require('process')

module.exports = (arg) ->
  process.stdin.destroy()
  if arg? and arg instanceof Error
    throw arg
  return arg
