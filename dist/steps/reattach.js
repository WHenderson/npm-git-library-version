var exec;

exec = require('../util/exec');

module.exports = function(branch) {
  return exec("git checkout " + branch);
};
