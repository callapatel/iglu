//
// pagination

  //$('.scroll').jscroll();

//
// ajax for a pin -- when a user clicks pin it to add it to their saved area.

  $(function () { $(".choose").click(function (e) {
    e.preventDefault();
    var div = $(this).parents("li.class");
    var url = $(this).parents("form").attr("action");
    var id = $(".info").val();
    $.ajax(url, {
      type: "POST",
      data: {pid: id},
      success: function () {
        div.addClass("chosen"); },
        error: function () {
          alert("ERROR");},
        });
      });
    });
