var process;

process = require('process');

module.exports = function(path) {
  return Promise.resolve().then(function() {
    return process.chdir(path);
  });
};
