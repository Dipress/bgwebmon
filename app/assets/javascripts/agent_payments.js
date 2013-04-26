// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
  $(function(){
    $('#agent_payment_search').typeahead({
      source: function (query, typeahead) {
        return $.ajax({
          url: '/api/get_contracts', 
          data: { search: query },
          dataType: 'json',
          success: function (data) {
            var labels = [];
            var ids = [];
            $.each(data.ajax, function(i,v){
              labels.push(v.name);
              ids[v.name] = v.id;
            });
            window.searchIds = ids;
            if(data.ajax.length >0){
              typeahead(labels);
            }
          }
        });
      },
      updater:function (item) {
        $('#agent_payment_contract_id').val(window.searchIds[item]);
        return item
      },
      minLength: 3
    });
    $('input[data-provide="typeahead"][autofocus]').trigger('focus');
  });