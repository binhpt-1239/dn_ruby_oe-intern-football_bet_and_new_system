require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

window.bootstrap = require("bootstrap");
import "../stylesheets/application.scss";

import I18n from "../i18n-js/index.js.erb"
window.I18n = I18n

var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;
