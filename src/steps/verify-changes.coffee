exec = require('../util/exec')

module.exports = (ignoreBower=false) ->
  exec('git status --porcelain --untracked-files=no')
  .then((out) ->
    lines = out.split('\n').map((line) -> line.trim()).filter((line) -> line != '')
    
    expected = [
      'package.json'
      'npm-shrinkwrap.json'
    ]
    if not ignoreBower
      expected.push('bower.json')
      
    if lines.length == 0
      throw new Error('Version not changed')

    lines = (line.replace(/^M\s+(.*)$/, '$1') for line in lines)
    if lines.some((line) -> expected.indexOf(line) == -1)
      throw new Error('Unexpected changes')

    return
  )
