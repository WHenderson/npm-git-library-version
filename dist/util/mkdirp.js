var mkdirp,
  slice = [].slice;

mkdirp = require('mkdirp');

module.exports = function() {
  var args;
  args = arguments;
  return new Promise(function(resolve, reject) {
    mkdirp.apply(null, slice.call(args).concat([function(err) {
      if (err != null) {
        return reject(err);
      }
      return resolve();
    }]));
  });
};
