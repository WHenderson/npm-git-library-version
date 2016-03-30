fs = require('fs')
wrap = require('./wrap')

module.exports = wrap(fs.stat)