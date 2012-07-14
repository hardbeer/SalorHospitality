/*
# BillGastro -- The innovative Point Of Sales Software for your Restaurant
# Copyright (C) 2012-2013  Red (E) Tools LTD
# 
# See license.txt for the license applying to all files within this software.
*/

function display_comment_popup_of_item(d) {
  if ( item_changeable(items_json[d].c, items_json[d].sc) ) {
    var old_comment = items_json[d].o;
    var comment = prompt(i18n.enter_comment, old_comment);
    if ( comment == null ) { comment = old_comment };
    add_comment_to_item(d,comment);
  }
}

function display_price_popup_of_item(d) {
  var old_price = items_json[d].p;
  if (old_price == 0) { old_price = '' }
  var price = prompt(i18n.enter_price, old_price);
  if ( price == null || price == '' ) {
    price = old_price;
  } else {
    price = price.replace(',', '.');
  }
  add_price_to_item(d,price);
}

function add_comment_to_item(d,comment) {
  d = clone_item(d);
	$('#comment_' + d).html(comment);
  set_json('order', d,'o',comment);
  $('#tablerow_' + d + '_label').addClass('updated');
  $('#item_configuration_' + d).hide();
}

function add_price_to_item(d,price) {
  d = clone_item(d);
  set_json('order', d,'p',price);
	$('#price_' + d).html(price);
	calculate_sum();
  $('#tablerow_' + d + '_label').addClass('updated');
  $('#item_configuration_' + d).hide();
}
