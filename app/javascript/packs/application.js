// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import $ from 'jquery';
global.$ = $;
import './modules/common/jquery-maskmoney.js';
import './modules/common/jquery.inputmask.min.js';

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require('webpack-jquery-ui');
require('webpack-jquery-ui/css');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


document.addEventListener('turbolinks:load', function() {
  $("#datepicker").datepicker({dateFormat: 'dd-mm-yy'});
  const paymentType = $(".cardselect").val();
  setPaymentForm(paymentType);
  $(".cardselect").change(function() {
    setPaymentForm(this.value);
  });
  initializeMaskMoney();
})

function setPaymentForm(value) {
  if (value === 'Bank') {
    $('.card_fields').hide();
    $('.bank_fields').show();
  } else {
    $('.bank_fields').hide();
    $('.card_fields').show();
  }
};

function initializeMaskMoney() {
  var elements = $(".maskmoney");
  elements.each(function(index, element) {
    $(element).maskMoney({ allowNegative: true, decimal: '.', affixesStay: false });
  });
};