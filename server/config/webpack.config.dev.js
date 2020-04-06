const webpack = require('webpack')
const merge = require('webpack-merge')
const base = require('./webpack.config')
module.exports = merge.smart(base, {
  mode: 'development',
  devServer: {
    port: process.env.PORT || 8080,
    after: (app, server, compiler)=>{
      app.get("/", require("../../server"))
    }
  }
});