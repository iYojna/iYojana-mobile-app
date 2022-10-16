import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate; //expiry date of token
  String? _userId;
  Timer? _authTimer;
  String? username;
  String? userEmail;

  String? errorCode;

  String? get error => errorCode;

  bool get isAuth {
    return _token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null)
      return _token;
    else
      return null;
  }

  Future<void> login(String? email, String? password) async {
    final url = Uri.parse('');
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }));
    print(response.statusCode);
    final extractedData = json.decode(response.body);

    if (response.statusCode >= 400) {
      print('inside throwing');
    }
    var timestamp = (extractedData['expire_at']);
    DateTime date = DateTime.parse(timestamp);

    _token = extractedData['key'];
    _expiryDate = date;
    _userId = extractedData['pk'].toString();

    //handling autologin from here
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
    });
    prefs.setString('userData', userData);
    await getUser();
    _autoLogout();

    notifyListeners();
  }

  Future<void> register(
      {required String username,
      required String password,
      required String firstName,
      required String lastName,
      required String dob,
      required String gender,
      required String income,
      required String maritalStatus,
      required String caste,
      required String edQual,
      required String district,
      required String phone}) async {
    print("IN THIS");
    print(dob);
    print(DateFormat('yyyy-MM-dd').parse(dob).toString());
    final url =
        Uri.parse('https://iyojna-backend.herokuapp.com/user/register/');
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'username': "asasasa",
          "password": "demopass",
          "first_name": "AHAHAH",
          "last_name": "AHAHAHA",
          "dob": dob, //dd-MM-y
          "income": income,
          "marital_status": maritalStatus,
          "caste": caste,
          "gender": gender,
          "district": district,
          "educational_qualification": edQual,
          "phone_no": "+91" + phone
        }));
    print("WAITING...");
    print("printing request: ");
    print(response.statusCode);
    print(json.decode(response.body));
    final extractedData = json.decode(response.body);
    print(extractedData.toString());
    if (response.statusCode >= 400) {
      print(response.statusCode);
      throw "HTTP Exception";
    }
    errorCode = response.statusCode.toString();
    notifyListeners();
  }

  Future<bool> checkOTP({required String pin, required String phoneNo}) async {
    print(phoneNo);
    print(pin);
    final url =
        Uri.parse('https://iyojna-backend.herokuapp.com/user/verify-otp/');
    final response = await http.post(url,
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: json.encode({"phone_no": phoneNo, "OTP": pin}));
    print("WAITING...");
    print("printing request: ");
    print(response.statusCode);
    print(json.decode(response.body));
    final extractedData = json.decode(response.body);
    print(extractedData.toString());
    if (extractedData["otp"] == "Successfully verified") {
      return true;
    }
    return false;
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print('trying auto login..');
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData = json.decode(prefs.getString('userData') as String)
        as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate'] as String);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'] as String;
    _userId = extractedData['userId'] as String;
    _expiryDate = expiryDate;
    await getUser();
    _autoLogout();
    notifyListeners();
    return true;
  }

  void logout() async {
    print('logging out..');
    _token = null;
    _userId = null;
    _expiryDate = null;
    userEmail = null;
    username = null;
    if (_authTimer != null) {
      //because if we loggin back immediately then old timer will continue
      // hence we need to first destroy old timer
      _authTimer!.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate?.difference(DateTime.now()).inSeconds ?? 1;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> getUser() async {
    final url = Uri.parse('');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token ${_token}',
      },
    );
    final extractedData = json.decode(response.body);
    username = extractedData['username'];
    userEmail = extractedData['email'];
  }
}
