'use strict';

var gulp = require('gulp');
var changedInPlace = require('gulp-changed-in-place');
var minifyHTML = require('gulp-htmlmin');

const DEST = './_site';
const HTML_PATH = './_site/**/*.html';

var minifyHTMLOptions = {
  collapseWhitespace: true,
  keepClosingSlash: true
}

gulp.task('minifyHTML', function(){
  return gulp.src(HTML_PATH)
             .pipe(changedInPlace({firstPass: true}))
             .pipe(minifyHTML(minifyHTMLOptions))
             .pipe(gulp.dest(DEST));
});

gulp.task('default', function(){
  console.log('No default task for gulp.');
});
