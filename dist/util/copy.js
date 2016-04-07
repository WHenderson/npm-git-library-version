var fs;

fs = require('fs');

module.exports = function(source, target) {
  return new Promise(function(resolve, reject) {
    var r, w;
    r = fs.createReadStream(source);
    r.on('error', reject);
    w = fs.createWriteStream(target);
    w.on('error', reject);
    w.on('finish', resolve);
    r.pipe(w);
  });
};
