var exec, readFile, stat, writeFile;

exec = require('../util/exec');

stat = require('../util/stat');

readFile = require('../util/read-file');

writeFile = require('../util/write-file');

module.exports = function(version, ignoreBower) {
  if (ignoreBower == null) {
    ignoreBower = false;
  }
  return Promise.resolve().then(function() {
    if (!ignoreBower) {
      return stat('bower.json').then(function() {
        return readFile('bower.json').then(function(data) {
          return JSON.parse(data.toString());
        }).then(function(json) {
          json.version = version;
          return writeFile('bower.json', JSON.stringify(json, null, 2));
        });
      }, function(err) {
        if (err.code === 'ENOENT') {
          return;
        }
        throw err;
      });
    }
  });
};
