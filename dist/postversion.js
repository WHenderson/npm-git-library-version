var exec, readPackage, reattach, verifyBranch, verifyClean;

readPackage = require('./steps/read-package');

verifyBranch = require('./steps/verify-branch');

verifyClean = require('./steps/verify-clean');

reattach = require('./steps/reattach');

exec = require('./util/exec');

module.exports = function(argv) {
  var pkg;
  pkg = null;
  return Promise.resolve().then(function() {
    if (!argv.ignoreBranch) {
      return verifyBranch(argv.branch);
    }
  }).then(function() {
    if (!argv.ignoreDirty) {
      return verifyClean();
    }
  }).then(function() {
    return readPackage().then(function(json) {
      return pkg = json;
    });
  }).then(function() {
    return Promise.resolve().then(function() {
      return exec("git checkout v" + pkg.version);
    }).then(function() {
      return Promise.resolve().then(function() {
        if (!argv.noGitPush) {
          return exec('git push');
        }
      }).then(function() {
        if (!argv.noGitPush) {
          return exec('git push --tags');
        }
      }).then(function() {
        if (!argv.noNpmPublish) {
          return exec('npm publish');
        }
      }).then(function() {
        return reattach(argv.branch);
      }, function(err) {
        return reattach(argv.branch).then(function() {
          throw err;
        });
      });
    });
  });
};
