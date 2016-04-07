var exec;

exec = require('../util/exec');

module.exports = function(files) {
  var add, fileName, fn, i, len;
  console.log('add files:', files);
  add = Promise.resolve();
  if (files != null) {
    fn = function(fileName) {
      return add = add.then(function() {
        return exec("git add -f " + fileName);
      });
    };
    for (i = 0, len = files.length; i < len; i++) {
      fileName = files[i];
      fn(fileName);
    }
  }
  return add;
};
