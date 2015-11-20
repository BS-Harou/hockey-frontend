ExtractTextPlugin = require('extract-text-webpack-plugin')
webpack = require('webpack');

//  
//  { test: /\.styl$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader!less-loader") }
// { test: /\.css$/, loader: ExtractTextPlugin.extract("style-loader", "css-loader") },

module.exports = {
    devtool: 'eval', // TODO, the fuck is this?
    entry: [
        'webpack-dev-server/client?http://0.0.0.0:8080', // WebpackDevServer host and port
        'webpack/hot/only-dev-server', // "only" prevents reload on syntax errors
        "./src/js/main.coffee"
    ],
    output: {
        path: __dirname,
        filename: "./build/main.js"
    },
    module: {
        loaders: [
            { test: /\.css$/, loader: "style!css?modules" },
            { test: /\.styl$/, loader: "style!css?modules!stylus" },
            { test: /\.cjsx$/, loader: "react-hot!coffee!cjsx-loader" },
            { test: /\.coffee$/, loader: "coffee-loader" },
            { test: /\.png$/, loader: "url-loader?limit=100000" },
            { test: /\.jpg$/, loader: "file-loader" },
            { test: /\.(eot|woff|woff2|ttf|svg)$/, loader: "file-loader" }
        ]
    },
    resolveLoader: {
        modulesDirectories: ['node_modules']
    },
    resolve: {
        extensions: ['', '.js', '.coffee', '.cjsx']
    },
    plugins: [
        new webpack.HotModuleReplacementPlugin()
    ]
};