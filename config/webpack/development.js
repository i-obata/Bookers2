process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()

const webpack = require('webpack')
environment.plugins.prepend(
    'provide',
    new webpack.providePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/sc/rc/jquery',
        Popper: 'popper.js'
    })
)
