// var ko = require("knockout");
document.addEventListener("turbolinks:load", () => {
  if (window.location.pathname == "/results") {
    getUnits();
  }
  $("#search_course_id").on("change", () => {
    getUnits();
  });
});

const getUnits = () => {
  course_dd = document.getElementById("search_course_id");
  units_dd = document.getElementById("search_unit_id");
  $("#search_unit_id").empty();
  $.getJSON(`/courses/${course_dd.value}/units_json`, function(data) {
    data.forEach(unit => {
      createOption(units_dd, unit.name, unit.id);
    });
  });
};

const createOption = (units_dd, text, value) => {
  var opt = document.createElement("option");
  opt.value = value;
  opt.text = text;
  units_dd.options.add(opt);
};
