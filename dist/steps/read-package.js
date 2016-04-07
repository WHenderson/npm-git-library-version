var exec, readFile;

exec = require('../util/exec');

readFile = require('../util/read-file');

module.exports = function() {
  return readFile('package.json').then(function(data) {
    return JSON.parse(data.toString());
  });
};
