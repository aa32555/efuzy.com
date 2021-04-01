/*
 * This file runs in a Node context (it's NOT transpiled by Babel), so use only
 * the ES6 features that are supported by your Node version. https://node.green/
 *
 * WARNING!
 * If you import anything from node_modules, then make sure that the package is specified
 * in package.json > dependencies and NOT in devDependencies
 *
 * Note: This file is used for both PRODUCTION & DEVELOPMENT.
 * Note: Changes to this file (but not any file it imports!) are picked up by the
 * development server, but such updates are costly since the dev-server needs a reboot.
 *  beforeParse (window) {
    console.log('running...', window.document)
   }
 */
const jsdom = require('jsdom')
const { JSDOM } = jsdom
const { window } = (new JSDOM('<html><body></body></html>', {
  url: 'http://localhost:' + (process.env.PORT || 3000),
  testURL: 'http://localhost:' + (process.env.PORT || 3000),
  pretendToBeVisual: false,
  includeNodeLocations: false
}))
const { document, navigator, getComputedStyle } = window
const { XMLHttpRequest } = require('xmlhttprequest')
const { File, Blob } = require('web-file-polyfill')

module.exports.extendApp = function ({ app, ssr }) {
  global.document = document
  global.window = window
  global.navigator = navigator
  global.XMLHttpRequest = XMLHttpRequest
  global.File = File
  global.Blob = Blob
  global.FileList = function () {}
  global.getComputedStyle = getComputedStyle
  Object.assign(global, { Q_HTML_ATTRS: '', Q_HEAD_TAGS: '', Q_BODY_ATTRS: '', Q_BODY_TAGS: '', Q_BODY_CLASSES: '' })
  /*
     Extend the parts of the express app that you
     want to use with development server too.

     Example: app.use(), app.get() etc
  */
}
