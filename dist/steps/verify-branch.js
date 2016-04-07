var exec;

exec = require('../util/exec');

module.exports = function(branch) {
  return exec('git rev-parse --abbrev-ref HEAD').then(function(out) {
    if (out.trim() !== branch) {
      throw new Error("HEAD is not \"" + branch + "\"");
    }
  });
};
