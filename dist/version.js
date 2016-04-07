var addFiles, commitChanges, detach, exec, readPackage, reattach, reset, revertCommit, syncVersion, verifyChanges;

verifyChanges = require('./steps/verify-changes');

readPackage = require('./steps/read-package');

syncVersion = require('./steps/sync-version');

commitChanges = require('./steps/commit-changes');

revertCommit = require('./steps/revert-commit');

reset = require('./steps/reset');

detach = require('./steps/detach');

reattach = require('./steps/reattach');

addFiles = require('./steps/add-files');

exec = require('./util/exec');

module.exports = function(argv) {
  var pkg;
  pkg = null;
  argv.files = argv._.slice(1);
  return Promise.resolve().then(function() {
    if (!argv.ignoreChanges) {
      return verifyChanges(argv.ignoreBower);
    }
  }).then(function() {
    return readPackage().then(function(json) {
      pkg = json;
      if (argv.files.length === 0 && (pkg.files != null)) {
        return argv.files = pkg.files.slice();
      }
    });
  }).then(function() {
    return Promise.resolve().then(function() {
      if (!argv.dontSync) {
        return syncVersion(pkg.version, argv.ignoreBower);
      }
    }).then(function() {
      if (!argv.dontCommitVersionChanges) {
        return commitChanges(pkg.version, argv.ignoreBower);
      }
    }).then(function() {
      return Promise.resolve().then(function() {
        return detach();
      }).then(function() {
        return Promise.resolve().then(function() {
          if (pkg.scripts.build != null) {
            return exec('npm run-script build').then(function() {
              return addFiles(argv.files);
            }).then(function() {
              return exec('git clean -fd');
            });
          }
        }).then(function() {
          return exec('npm test');
        }).then(function() {
          if (pkg.scripts.build == null) {
            return addFiles(argv.files).then(function() {
              return exec('git clean -fd');
            });
          }
        }).then(function() {
          return exec('git commit -m "distribution files"');
        }).then(function() {
          return exec("git tag -a \"v" + pkg.version + "\" -m \"v" + pkg.version + " for distribution\"");
        });
      }).then(function() {
        return reattach(argv.branch);
      }, function(err) {
        return reattach(argv.branch).then(function() {
          throw err;
        });
      });
    })["catch"](function(err) {
      if (!argv.dontCommitVersionChanges) {
        return revertCommit().then(function() {
          throw err;
        });
      } else {
        throw err;
      }
    });
  })["catch"](function(err) {
    return reset().then(function() {
      throw err;
    });
  });
};
