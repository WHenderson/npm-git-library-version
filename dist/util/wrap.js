var slice = [].slice;

module.exports = function(func) {
  return function() {
    var args;
    args = arguments;
    return new Promise(function(resolve, reject) {
      func.apply(null, slice.call(args).concat([function(err, result) {
        if (err != null) {
          return reject(err);
        }
        resolve(result);
      }]));
    });
  };
};
