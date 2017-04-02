'use strict';

var gulp = require('gulp');
var changedInPlace = require('gulp-changed-in-place');
var minifyHTML = require('gulp-htmlmin');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');

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

// Run this task manually after change JS files
gulp.task('minifyJS', function(){
    return gulp.src(['./_js/jquery-2.1.3.min.js', './_js/main.js'])
               .pipe(changedInPlace({firstPass: true}))
               .pipe(concat('global.js'))
               .pipe(uglify())
               .pipe(gulp.dest('./assets/js'));
});

gulp.task('default', function(){
  console.log('No default task for gulp.');
});
