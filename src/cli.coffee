argv = require('./argv').argv
closeStdin = require('./steps/close-stdin')

action = switch argv._[0]
  when 'preversion'
    require('./preversion')
  when 'version'
    require('./version')
  when 'postversion'
    require('./postversion')

action(argv)
.then(closeStdin, closeStdin)
.then(
  () ->
    process.exit(0)

  (err) ->
    console.error('Operation failed.')
    console.error(err)
    console.error(err.stack)
    process.exit(-1)
)

