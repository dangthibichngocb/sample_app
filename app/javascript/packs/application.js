// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
Rails.start();
Turbolinks.start();
ActiveStorage.start();
require("jquery");
require("bootstrap");

import I18n from "i18n-js"

$("#micropost_image").bind("change", function () {
    var size_in_megabytes = this.files[0].size / 1024 / 1024;
    if (size_in_megabytes > 5) {
        alert(I18n.t(".alert_err"));
    }
});
