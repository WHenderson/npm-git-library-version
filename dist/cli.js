#!/usr/bin/env node
var action, argv, closeStdin;

argv = require('./argv').argv;

closeStdin = require('./steps/close-stdin');

action = (function() {
  switch (argv._[0]) {
    case 'preversion':
      return require('./preversion');
    case 'version':
      return require('./version');
    case 'postversion':
      return require('./postversion');
  }
})();

action(argv).then(closeStdin, closeStdin).then(function() {
  return process.exit(0);
}, function(err) {
  console.error('Operation failed.');
  console.error(err);
  console.error(err.stack);
  return process.exit(-1);
});
