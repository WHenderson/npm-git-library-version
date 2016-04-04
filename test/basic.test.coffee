exec = require('../src/util/exec')
rimraf = require('../src/util/rimraf')
mkdirp = require('../src/util/mkdirp')

suite('basic', () ->
  suiteSetup(() ->
    rimraf('test/pkgs')
  )

  test('vanilla', () ->
    mkdirp('test/pkgs/vanilla')
  )
)