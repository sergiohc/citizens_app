module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/components/**/*.{erb,html}',
    './node_modules/flowbite/**/*.js'
  ],

  plugins: [
    require('flowbite/plugin')
  ]
}
