$('button,[data-inventory-item-id]').click(function() {
  var inventoryID = $(this).data('inventory-item-id');
  $('#inventoryID').prop('value', inventoryID);
  $('#addListItem').modal('show');
});
