var closeStdin, verifyBranch, verifyClean;

verifyBranch = require('./steps/verify-branch');

verifyClean = require('./steps/verify-clean');

closeStdin = require('./steps/close-stdin');

Promise.resolve().then(function() {}).then(verifyBranch('master')).then(verifyClean())["catch"](function(err) {
  return console.log(err);
}).then(closeStdin, closeStdin);
