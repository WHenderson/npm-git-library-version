var exec;

exec = require('../util/exec');

module.exports = function(ignoreBower) {
  if (ignoreBower == null) {
    ignoreBower = false;
  }
  return exec('git status --porcelain --untracked-files=no').then(function(out) {
    var expected, line, lines;
    lines = out.split('\n').map(function(line) {
      return line.trim();
    }).filter(function(line) {
      return line !== '';
    });
    expected = ['package.json', 'npm-shrinkwrap.json'];
    if (!ignoreBower) {
      expected.push('bower.json');
    }
    if (lines.length === 0) {
      throw new Error('Version not changed');
    }
    lines = (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = lines.length; i < len; i++) {
        line = lines[i];
        results.push(line.replace(/^M\s+(.*)$/, '$1'));
      }
      return results;
    })();
    if (lines.some(function(line) {
      return expected.indexOf(line) === -1;
    })) {
      throw new Error('Unexpected changes');
    }
  });
};
