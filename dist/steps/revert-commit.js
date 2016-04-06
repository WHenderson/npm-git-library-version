var exec;

exec = require('../util/exec');

module.exports = function() {
  return exec('git reset --hard HEAD~');
};
