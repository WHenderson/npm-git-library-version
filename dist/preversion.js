var verifyBranch, verifyClean;

verifyBranch = require('./steps/verify-branch');

verifyClean = require('./steps/verify-clean');

module.exports = function(argv) {
  return Promise.resolve().then(function() {
    if (!argv.ignoreBranch) {
      return verifyBranch(argv.branch);
    }
  }).then(function() {
    if (!argv.ignoreDirty) {
      return verifyClean();
    }
  });
};
