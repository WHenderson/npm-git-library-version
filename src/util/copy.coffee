fs = require('fs')

module.exports = (source, target) ->
  new Promise((resolve, reject) ->
    r = fs.createReadStream(source)
    r.on('error', reject)
    w = fs.createWriteStream(target)
    w.on('error', reject)
    w.on('finish', resolve)
    r.pipe(w)
    
    return
  )