var exec;

exec = require('../util/exec');

module.exports = function() {
  return exec('git checkout head');
};
