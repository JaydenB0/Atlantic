const webpack = require('webpack')
const merge = require('webpack-merge')
const base = require('./webpack.config')


module.exports = merge.smart(base, {
  mode: 'production'
})