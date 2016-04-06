var fs, wrap;

fs = require('fs');

wrap = require('./wrap');

module.exports = wrap(fs.writeFile);
