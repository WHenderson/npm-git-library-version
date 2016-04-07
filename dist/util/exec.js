var child_process, colors, process;

child_process = require('child_process');

process = require('process');

colors = require('colors/safe');

module.exports = function(command, options) {
  return new Promise(function(resolve, reject) {
    var fn, i, len, myProcess, ref, streamName;
    myProcess = child_process.exec(command, options, function(err, stdout, stderr) {
      if (err != null) {
        return reject(err);
      }
      return resolve(stdout);
    });
    process.stdout.write(colors.blue("> " + command) + '\n');
    if (myProcess != null) {
      ref = ['stdout', 'stdin'];
      fn = function(streamName) {
        return myProcess[streamName].addListener('data', function(chunk) {
          process[streamName].write(chunk);
        });
      };
      for (i = 0, len = ref.length; i < len; i++) {
        streamName = ref[i];
        fn(streamName);
      }
      if ((myProcess.stdin != null) && (process.stdin != null)) {
        process.stdin.resume();
        process.stdin.pipe(myProcess.stdin);
        myProcess.addListener('close', function() {
          process.stdin.unpipe(myProcess.stdin);
          return process.stdin.pause();
        });
      }
    }
    return myProcess;
  });
};
