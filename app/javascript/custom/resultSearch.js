document.addEventListener("turbolinks:load", () => {
  if (window.location.pathname == "/results") {
    getUnits();
  }
  $("#search_course_id").on("change", () => {
    getUnits();
  });
});

const getUnits = () => {
  var course_dd = document.getElementById("search_course_id");
  var units_dd = document.getElementById("search_unit_id");
  $("#search_unit_id").empty();
  $.getJSON(`/courses/${course_dd.value || 0}/units_json`, function(data) {
    data.forEach(unit => {
      var urlParams = new URLSearchParams(window.location.search);
      var selected = false;
      if (urlParams.has("search[unit_id]")) {
        if (parseInt(urlParams.get("search[unit_id]")) === unit.id) {
          selected = true;
        }
      }
      createOption(units_dd, unit.name, unit.id, selected);
    });
  });
};

const createOption = (units_dd, text, value, selected) => {
  var opt = document.createElement("option");
  opt.value = value;
  opt.text = text;
  opt.selected = selected;
  units_dd.options.add(opt);
};
