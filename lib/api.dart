import 'dart:async';
import "dart:convert";
import 'package:http/http.dart' as http;

class Api {
  // static final PATH = "https://tdl-backend.herokuapp.com/tasks/";
  static final PATH = "http://10.40.1.57:8080/tasks/";

  static Future findAll() async {
    http.Response response = await http.get("${Api.PATH}");
    return json.decode(response.body);
  }

  static Future create(taskDescription) async {
    var taskJson = json.encode({"description": taskDescription});
    var contentType = {"Content-type": "application/json"};
    var response =
        await http.post(Api.PATH, body: taskJson, headers: contentType);

    return json.decode(response.body);
  }

  static Future update(id, task) async {
    var taskJson = json.encode(task);
    var contentType = {"Content-type": "application/json"};
    var response =
        await http.put("${Api.PATH}/$id", body: taskJson, headers: contentType);
    return json.decode(response.body);
  }

  static Future complete(id) async {
    http.Response response = await http.put("${Api.PATH}/$id");
    return response;
  }

  static Future delete(id) async {
    http.Response response = await http.delete("${Api.PATH}/$id");
    return response;
  }
}
