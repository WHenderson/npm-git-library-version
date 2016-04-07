var process;

process = require('process');

module.exports = function(arg) {
  process.stdin.destroy();
  if ((arg != null) && arg instanceof Error) {
    throw arg;
  }
  return arg;
};
