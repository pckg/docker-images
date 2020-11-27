/**
 * webpack --env.SHARE_TYPE=list --env.SHARE=unusual-list --env.SHARE_VENDOR=comms
 */
const merge = require('webpack-merge');
const base = require('./webpack.base.js');

module.exports = (env) => {

    let capitalize = function (str) {
        if (str.indexOf('-') > 0) {
            return str.split('-').map(capitalize).join('');
        }
        return str.charAt(0).toUpperCase() + str.slice(1)
    };

    let param = function (name, def) {
        if (env && typeof env[name] !== 'undefined') {
            return env[name];
        }

        return def;

        throw name + " must be defined ";
    }

    let shareName = param('SHARE', 'item');
    let shareType = param('SHARE_TYPE', 'item');
    let shareVendor = param('SHARE_VENDOR', 'comms');

    if (!(['list', 'item', 'page', 'style', 'component', 'layout', 'theme'].indexOf(shareType) >= 0)) {
        throw 'Invalid share type';
    }

    /**
     * Prefix jsonpFunction with unique name.
     */
    let library = capitalize(['hub', shareType, shareVendor, shareName].join('-'));
    let entry = {};

    /**
     * Use standardized entry files.
     */
    entry[shareName] = './' + shareName + '.js';

    return merge(base, {
        entry: entry,
        output: {
            path: process.cwd() + '/build',
            library: library
        }
    })
};