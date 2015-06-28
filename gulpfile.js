var gulp  = require('gulp'),
    browserify = require('gulp-browserify'),
    gutil = require('gulp-util'),
    cjsx = require('gulp-cjsx'),
    clean = require('gulp-clean'),
    runSeq = require('run-sequence'),
    stylus = require('gulp-stylus'),
    coffee = require('gulp-coffee');

gulp.task('clean', function () {
	return gulp.src(['./build/*', './src/js/*.js'])
	.pipe(clean());
});

gulp.task('cjsx', function() {
	return gulp.src('./src/js/*.cjsx')
	.pipe(cjsx({bare: true}).on('error', gutil.log))
	.pipe(gulp.dest('./src/js/'));
});

gulp.task('coffee', function() {
	return gulp.src('./src/js/*.coffee')
	.pipe(coffee({bare: true}).on('error', gutil.log))
	.pipe(gulp.dest('./src/js/'));
});

gulp.task('browserify', function() {
	return gulp.src('src/js/main.js')
	.pipe(browserify({
		insertGlobals: true,
		debug: !gulp.env.production
	}))
	.pipe(gulp.dest('./build'));
});

gulp.task('stylus', function () {
  gulp.src(['./src/css/main.styl'])
    .pipe(stylus({ compress: true, 'include css': true, 'include': '.' }))
    .pipe(gulp.dest('./build/'));
});

gulp.task('default', function(cb) {
	runSeq('clean', 'cjsx', 'coffee', 'browserify', 'stylus', cb);
});

