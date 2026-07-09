import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

// void main() async {
//   // Create API url
//   Uri url = Uri.parse(
//     "https://fluttert1-df862-default-rtdb.asia-southeast1.firebasedatabase.app/Button.json",
//   );

//   // Send request
//   Response response = await http.get(url);

//   // Check status code
//   if (response.statusCode != 200) {
//     throw Exception("Cannot fetch the data");
//   }

//   Map<String, dynamic> json = jsonDecode(response.body);
//   Buton b = Buton(name: json['name'], selected: json['selected']);

//   print("${b.selected} and ${b.name}");
// }

// class Buton {
//   final String name;
//   final bool selected;

//   Buton({required this.name, required this.selected});
// }

Future<ButtonStatus> getButtonStatus() async {
  // 1- Fetch the data from firebase
  Uri url = Uri.parse(
    "https://fluttert1-df862-default-rtdb.asia-southeast1.firebasedatabase.app/Button.json",
  );
  // Check status code
  Response re = await http.get(url);
  if (re.statusCode != 200) {
    throw Exception("Cannot fetch the data...");
  }
  Map<String, dynamic> data = jsonDecode(re.body);
  // 2- Create a ButtonStatus and return it
  ButtonStatus b = ButtonStatus(name: data['name'], selected: data['selected']);

  return b;
  // 3- handle possible errors
}

class ButtonStatus {
  final String name;
  final bool selected;

  ButtonStatus({required this.name, required this.selected});
}

void main() async {
  ButtonStatus button = await getButtonStatus();
  print(button.name);
  print(button.selected);
}
