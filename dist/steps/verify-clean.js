var exec;

exec = require('../util/exec');

module.exports = function() {
  return exec('git status --porcelain').then(function(out) {
    if (out.trim() !== '') {
      throw new Error("Working folder is not clean");
    }
  });
};
