//
// pagination

  $('.scroll').jscroll();

//
// ajax for a pin -- when a user clicks pin it to add it to their saved area.

  $(function () { $(".choose").click(function (e) {
    e.preventDefault();
    var div = $(this).parents(".club");
    var url = $(this).parents("form").attr("action");
    var d = $(".info").val();
    $.ajax(url, {
      type: "POST",
      success: function (data) {
        div.addClass("chosen"); },
        error: function () {
          alert("ERROR");},
          data: {uid: d},
        });
      });
    });
