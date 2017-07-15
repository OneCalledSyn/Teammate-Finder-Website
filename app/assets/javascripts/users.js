/* global $, Stripe */
// Document ready
$(document).on('turbolinks:load', function(){
  var theForm = $('#pro_form');
  var submitBtn = $('#form-signup-btn');
  
  //Set Stripe public key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content'));
  
  //When user clicks submit form button, prevent default submission behavior
  submitBtn.click(function(event){
    event.preventDefault();
  });

  //Collect the credit card fields
  //Send the card info to Stripe
  //Stripe returns a card token
  //Inject the card token into form as a hidden field
  //Submit form to Rails app
});

