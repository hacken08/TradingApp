import 'package:trading_app/utils/const.dart';

bool validateEmail(String value) {
  return RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  ).hasMatch(value);
}

String longtext(String text, int long) {
  if (text.length <= long) {
    return text;
  } else {
    return '${text.substring(0, long)} ...';
  }
}

String genUrl(String path, Map<String, dynamic> parameters) {
  String params = "";
  parameters.forEach((key, value) {
    params += "&$key=$value";
  });

  return "$apiUrl$path?apikey=$apikey$params";
}
