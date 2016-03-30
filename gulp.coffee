gulp = require('gulp')
g =
  rimraf: require('gulp-rimraf')
  coffee: require('gulp-coffee')
  mocha: require('gulp-spawn-mocha')
  util: require('gulp-util')

tasks =
  clean: () ->
    gulp
    .src('dist', { read: false, allowEmpty: true })
    .pipe(g.rimraf())

  build: () ->
    gulp
    .src('src/**/*.coffee')
    .pipe(g.coffee({ bare: true }))
    .pipe(gulp.dest('dist'))

  test: () ->
    gulp
    .src('test/**/*.test.coffee')
    .pipe(g.mocha({
      debugBrk: false
      r: 'test/coverage-setup.js'
      R: 'spec'
      u: 'tdd'
      istanbul: {}
    }))

  watch: () ->
    gulp.watch('src', gulp.series('chained-2-test'))
    gulp.watch('templates', gulp.series('discrete-2-test'))
    gulp.watch('test', gulp.series('discrete-2-test'))
    return

do ->
  for taskName, task of tasks
    task.displayName = taskName

gulp.task('discrete-0-clean', tasks.clean)
gulp.task('discrete-1-build', tasks.build)
gulp.task('discrete-2-test', tasks.test)
gulp.task('discrete-3-watch', tasks.watch)

gulp.task('chained-0-clean', gulp.series('discrete-0-clean'))
gulp.task('chained-1-build', gulp.series('chained-0-clean', 'discrete-1-build'))
gulp.task('chained-2-test', gulp.series('chained-1-build', 'discrete-2-test'))
gulp.task('chained-3-watch', gulp.series(
  'chained-1-build',
  () ->
    tasks
    .test()
    .on('error', g.util.log)
  'discrete-3-watch'
))

gulp.task('default', gulp.series('chained-2-test'))
