var exec, stat;

exec = require('../util/exec');

stat = require('../util/stat');

module.exports = function(version, ignoreBower) {
  var expected, fn, i, len, name, promise;
  if (ignoreBower == null) {
    ignoreBower = false;
  }
  expected = ['package.json', 'npm-shrinkwrap.json'];
  if (!ignoreBower) {
    expected.push('bower.json');
  }
  promise = Promise.resolve();
  fn = function(name) {
    return promise = promise.then(function() {
      return stat(name).then(function() {
        return exec("git add " + name);
      }, function(err) {
        if (err.code === 'ENOENT') {
          return;
        }
        throw err;
      });
    });
  };
  for (i = 0, len = expected.length; i < len; i++) {
    name = expected[i];
    fn(name);
  }
  return promise.then(function() {
    return exec("git commit -m \"v" + version + "\"").then(function() {});
  });
};
