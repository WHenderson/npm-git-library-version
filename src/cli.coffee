argv = require('./argv')

switch argv._[0]
  when 'preversion'
    require('./preversion')(argv)
  when 'version'
    require('./version')(argv)
