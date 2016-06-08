// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require spin.min
//= require ladda.min
//= require jquery_ujs
//= require base.min
//= require components
//= require smartbanner.min
//= require select2.full.min
//= require sweetalert.min
//= require_self
//= require_tree .

function formatSelect2(){
  $('select.select-scores').select2({
    maximumSelectionLength: 3,
    placeholder: 'Click vào đây để chọn tỉ số...',
    language: 'vi'
  });
  $('select.select-users, select.select-score, select.select-team').select2({
    language: 'vi'
  });
  $('select.admin-select-team, select.admin-predict-team').select2({
    language: 'vi',
    width: '80%'
  });
}