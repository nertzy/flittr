describe("submitting the form", function() {
  afterEach(function() {
    $("#testForm").remove();
    $("#spinner").remove();
  });

  it("shows a big spinner", function() {
    var fixture = "<form id='testForm'></form><div id='spinner' style='display:none;'></div>";

    $(document.body).append(fixture);

    var form = $("#testForm");
    var spinner = $("#spinner");

    form.submit(function(event){
      event.preventDefault();
    });

    $(document).ready();

    expect(spinner.is(":visible")).toBeFalsy();

    form.trigger("submit");

    expect(spinner.is(":visible")).toBeTruthy();
  });
});
