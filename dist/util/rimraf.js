var rimraf,
  slice = [].slice;

rimraf = require('rimraf');

module.exports = function() {
  var args;
  args = arguments;
  return new Promise(function(resolve, reject) {
    rimraf.apply(null, slice.call(args).concat([function(err) {
      if (err != null) {
        return reject(err);
      }
      return resolve();
    }]));
  });
};
