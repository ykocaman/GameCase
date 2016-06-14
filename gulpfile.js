// Load plugins
var gulp      = require('gulp'),
    minifycss = require('gulp-minify-css'),
    uglify    = require('gulp-uglify'),
    rename    = require('gulp-rename'),
    exec      = require('child_process').exec,
    sys       = require('sys');

var publicDir = 'public/assets/',
    resourceDir     = 'resources/';

gulp.task('styles', function() {
  gulp.src(resourceDir + 'css/style.css')
  .pipe(minifycss())
  .pipe(rename('compiled.css'))
  .pipe(gulp.dest(publicDir + 'css'));
});

gulp.task('scripts', function() {
    gulp.src([
        resourceDir + 'js/app.js'])
    .pipe(uglify())
    .pipe(rename('compiled.js'))
    .pipe(gulp.dest(publicDir + 'js'));
});

gulp.task('phpunit', function() {
    exec('phpunit', function(error, stdout) {
        sys.puts(stdout);
    });
});

gulp.task('watch', function() {
    gulp.watch(resourceDir + 'css/**/*', ['styles']);
    gulp.watch(resourceDir + 'js/**/*', ['scripts']);
    gulp.watch('app/**/*.php', ['phpunit']);
});

gulp.task('default', ['scripts', 'styles', 'watch']);
