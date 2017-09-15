/**
 * Created by 1 on 10.10.2015.
 */

$(document).ready(function() {






  // custom-events
  $('.custom-event').on('show-before', function() {
    console.log('show-before!')
  });

  $('.custom-event').on('show-complete', function() {
    console.log('show-complete!');
  });

  $('.custom-event').on('hide-before', function() {
    console.log('hide-before!');
  });

  $('.custom-event').on('hide-complete', function() {
    console.log('hide-complete!');
  });

  // destroy
  $('.destroy-element').on('click', function(event) {
    event.preventDefault();
    $('.destroy-current').myTooltip('destroy');
  });



  $('.add-element').on('click', function(event) {
    event.preventDefault();
    $(this).after('<br><div style="margin: 10px 0;" class="js-mytooltip type-inline-block style-block style-block-three"' +
        ' data-mytooltip-animate-duration="150" data-mytooltip-direction="left" data-mytooltip-custom-class="align-center"' +
        ' data-mytooltip-template="Wow!<br> This dinamic element!">New element</div>');

 
  });


});
