module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web.ex',
    '../lib/*_web/**/*.*ex',
  ],
  plugins: [
    require('@tailwindcss/typography'),
    require('daisyui')
  ],
}
