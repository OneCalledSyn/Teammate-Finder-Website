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
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect the credit card fields
    var ccNum = $('#card_number').val();
    var cvcNum = $('#card_code').val();
    var expMonth = $('#card_month').val();
    var expYear = $('#card_year').val();
    
    //Use Stripe JS library to check for card errors
    var error = false;
    
    //Validate card number
    if (!Stripe.card.validateCardNumber(ccNum)) {
      error = true;
      alert('The credit card number seems to be invalid')
    }
    
    //Validate CVC number (Taking out bang operator makes it work, not sure why)
    if (!Stripe.card.validateCVC(cvcNum)) {
      error = true;
      alert('The CVC number seems to be invalid')
    }
    
    //Validate expiration date
    if (!Stripe.card.validateExpiry(expMonth, expYear)) {
      error = true;
      alert('The expiration date seems to be invalid')
    }
    
    if (error) {
      //If card errors present, do not send to Stripe
      submitBtn.val("Sign Up").prop('disabled', false);
    } else {
      //Send the card info to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    }
    
    return false;
    });

  //Stripe returns a card token
  function stripeResponseHandler(status, response) {
    var token = response.id;
    
    //Inject the card token into form as a hidden field
    theForm.append( $('<input type= "hidden" name= "user[stripe_card_token]">').val(token) );
    
    //Submit form to Rails app
    theForm.get(0).submit();
  }
});

