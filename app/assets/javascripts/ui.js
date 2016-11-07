function properties() {
  $("#path").val('properties');
  $("#notes").html("Notes: REST service for properties.");
  $("#json").val(
    "\n  {\n" +
    "    \"name\": \"San Jose Diridon Station\",\n" +
    "    \"street\": \"65 Cahill St\",\n" +
    "    \"city\": \"San Jose\",\n" +
    "    \"state\": \"CA\",\n" +
    "    \"latitude\": 37.329875,\n" +
    "    \"longitude\": -121.902517,\n" +
    "    \"status\": \"rented\",\n" +
    "    \"agent_id\": 23,\n" +
    "    \"resident_id\": 24,\n" +
    "    \"auth_token\": \"Of04p3eLBO71fof2stHYIQ\"\n" +
    "  }"
  );
}

function activities() {
  $("#path").val('activities');
  $("#notes").html("Notes: REST service for activities.");
  $("#json").val(
    "\n  {\n" +
    "    \"event\": \"Property rented: Stack Apartment\",\n" +
    "    \"user_id\": 4,\n" +
    "    \"date\": \"2016-01-01T23:59:59\",\n" +
    "    \"auth_token\": \"Of04p3eLBO71fof2stHYIQ\"\n" +
    "  }"
  );
}
