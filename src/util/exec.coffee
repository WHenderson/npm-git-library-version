child_process = require('child_process')
process = require('process')
colors = require('colors/safe')

module.exports = (command, options) ->
  new Promise((resolve, reject) ->
    myProcess = child_process.exec(command, options, (err, stdout, stderr) ->
      if err?
        return reject(err)

      return resolve(stdout)
    )

    process.stdout.write(colors.blue("> #{command}") + '\n')

    if myProcess?
      for streamName in ['stdout', 'stdin']
        do (streamName) ->
          myProcess[streamName].addListener('data', (chunk) ->
            process[streamName].write(chunk)
            return
          )

      if myProcess.stdin? and process.stdin?
        process.stdin.resume()
        process.stdin.pipe(myProcess.stdin)

        myProcess.addListener('close', () ->
          process.stdin.unpipe(myProcess.stdin)
          process.stdin.pause()
        )

    return myProcess
  )
