exec = require('../src/util/exec')
rimraf = require('../src/util/rimraf')
mkdirp = require('../src/util/mkdirp')
chdir = require('../src/util/chdir')
copy = require('../src/util/copy')
path = require('path')

suite('basic', () ->
  @timeout(0)

  suiteSetup(() ->
    rimraf('test/pkgs')
  )

  test('vanilla', () ->
    mkdirp('test/pkgs/vanilla')
    .then -> chdir(path.join(__dirname, 'pkgs/vanilla'))
    .then -> exec('git init')
    .then -> copy(path.join(__dirname, 'fixtures/vanilla.gitignore'), '.gitignore')
    .then -> copy(path.join(__dirname, 'fixtures/vanilla.npmrc'), '.npmrc')
    .then -> copy(path.join(__dirname, 'fixtures/vanilla.package.json'), 'package.json')
    .then -> exec('npm install')
    .then -> exec('git add *')
    .then -> exec('git commit -m initial')
    .then -> exec('git status')
  )
)