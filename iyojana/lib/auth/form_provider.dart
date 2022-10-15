import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier{
  String? phoneNumber;
  String? dateOfBirth;
  String? gender;
  String? income;
  String? maritalStatus;
  String? caste;
  String? edQual;
  String? place;

  String? get getPhoneNumber => phoneNumber;
  String? get getDateOfBirth => dateOfBirth;
  String? get getGender => gender;
  String? get getIncome => income;
  String? get getMaritalStatus => maritalStatus;
  String? get getCaste => caste;
  String? get getEdQual => edQual;
  String? get getPlace => place;

  String? setPhoneNumber(String? value){
    phoneNumber = value;
    notifyListeners();
  }

  String? setDOB(String? value){
    dateOfBirth= value;
    notifyListeners();
  }

  String? setGender(String? value){
    gender = value;
    notifyListeners();
  }
  String? setIncome(String? value){
    income = value;
    notifyListeners();
  }

  String? setMaritalStatus(String? value){
    maritalStatus = value;
    notifyListeners();
  }

  String? setCaste(String? value){
    caste = value;
    notifyListeners();
  }

  String? setEdquality(String? value){
    edQual = value;
    notifyListeners();
  }
  String? setPlace(String? value){
    place = value;
    notifyListeners();
  }
  
  



}