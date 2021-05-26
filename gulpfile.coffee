gulp = require 'gulp'
gulpPug = require 'gulp-pug'
gulpChmod = require 'gulp-chmod'

exports.pug = pug = ->
  gulp.src 'index.pug'
  .pipe gulpPug pretty: true
  .pipe gulpChmod 0o644
  .pipe gulp.dest './'

exports.watch = watch = ->
  gulp.watch '*.pug', pug
  gulp.watch '*.styl', pug
  gulp.watch '*.coffee', pug

exports.default = pug
