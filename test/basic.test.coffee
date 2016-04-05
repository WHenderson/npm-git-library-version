exec = require('../src/util/exec')
rimraf = require('../src/util/rimraf')
mkdirp = require('../src/util/mkdirp')
chdir = require('../src/util/chdir')
copy = require('../src/util/copy')
path = require('path')
assert = require('chai').assert

suite('basic', () ->
  @timeout(0)

  suiteSetup(() ->
    rimraf('test/pkgs')
  )

  suite('vanilla', () ->
    test('scafolding', () ->
      mkdirp(path.join(__dirname, 'pkgs/vanilla'))
      .then -> chdir(path.join(__dirname, 'pkgs/vanilla'))
      .then -> exec('git init')
      .then -> exec('git config user.name TestUser')
      .then -> exec('git config user.email testuser@example.com')
      .then -> copy(path.join(__dirname, 'fixtures/vanilla.gitignore'), '.gitignore')
      .then -> copy(path.join(__dirname, 'fixtures/vanilla.npmrc'), '.npmrc')
      .then -> copy(path.join(__dirname, 'fixtures/vanilla.package.json'), 'package.json')
      .then -> exec('npm install')
      .then -> exec('git add *')
      .then -> exec('git commit -m initial')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
          '''
          On branch master
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
          '''
          .gitignore
          .npmrc
          package.json

          '''
        )
      )
    )

    test('version bump', () ->
      exec('npm version major')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
                    '''
          On branch master
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
                    '''
          .gitignore
          .npmrc
          package.json

          '''
        )
      )
      .then -> exec('git checkout v2.0.0')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
          '''
          HEAD detached at v2.0.0
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
          '''
          .gitignore
          .npmrc
          dist/a.txt
          dist/b.txt
          package.json

          '''
        )
      )
    )
  )

  suite('coverage', () ->
    test('scafolding', () ->
      mkdirp(path.join(__dirname, 'pkgs/coverage'))
      .then -> chdir(path.join(__dirname, 'pkgs/coverage'))
      .then -> exec('git init')
      .then -> exec('git config user.name TestUser')
      .then -> exec('git config user.email testuser@example.com')
      .then -> copy(path.join(__dirname, 'fixtures/vanilla.gitignore'), '.gitignore')
      .then -> copy(path.join(__dirname, 'fixtures/vanilla.npmrc'), '.npmrc')
      .then -> copy(path.join(__dirname, 'fixtures/coverage.package.json'), 'package.json')
      .then -> exec('npm install')
      .then -> exec('git add *')
      .then -> exec('git commit -m initial')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
                    '''
          On branch master
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
                    '''
          .gitignore
          .npmrc
          package.json

          '''
        )
      )
    )

    test('version bump', () ->
      exec('npm version major')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
                    '''
          On branch master
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
                    '''
          .gitignore
          .npmrc
          package.json

          '''
        )
      )
      .then -> exec('git checkout v2.0.0')
      .then -> exec('git status')
      .then((out) ->
        assert.equal(
          out,
                    '''
          HEAD detached at v2.0.0
          nothing to commit, working directory clean

          '''
        )
      )
      .then -> exec('git ls-files')
      .then((out) ->
        assert.equal(
          out,
                    '''
          .gitignore
          .npmrc
          dist/a.txt
          dist/b.txt
          package.json

          '''
        )
      )
    )
  )
)