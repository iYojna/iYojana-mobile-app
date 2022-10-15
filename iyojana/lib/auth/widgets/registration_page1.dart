import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iyojana/auth/widgets/custom_dropdown.dart';
import 'package:iyojana/auth/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../form_provider.dart';

class RegistrationPage1 extends StatefulWidget {
  const RegistrationPage1({Key? key}) : super(key: key);

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  List<String> genderOptions = ["Male", "Female", "Rather not say"];

  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(builder: (context, formProvider, _) {
      void _onSpeechResultPhone(SpeechRecognitionResult result) {
        setState(() {
          _lastWords = result.recognizedWords;
          print(_lastWords);
          formProvider.setPhoneNumber(_lastWords);
          print("LOL" + formProvider.getPhoneNumber.toString());
        });
      }

      void _onSpeechResultIncome(SpeechRecognitionResult result) {
        setState(() {
          _lastWords = result.recognizedWords;
          print(_lastWords);
          formProvider.setIncome(_lastWords);
          print("LOL" + formProvider.getPhoneNumber.toString());
        });
      }

      void _onSpeechResultLocation(SpeechRecognitionResult result) {
        setState(() {
          _lastWords = result.recognizedWords;
          print(_lastWords);
          formProvider.setPlace(_lastWords);
          print("LOL" + formProvider.getPlace.toString());
        });
      }

      void _startListeningPhone() async {
        await _speechToText.listen(onResult: _onSpeechResultPhone);
        setState(() {});
      }

      void _startListeningIncome() async {
        await _speechToText.listen(onResult: _onSpeechResultIncome);
        setState(() {});
      }

      void _startListeningLocation() async {
        await _speechToText.listen(onResult: _onSpeechResultLocation);
        setState(() {});
      }

      void _stopListening() async {
        print("stopped");
        await _speechToText.stop();
        setState(() {});
      }

      return Form(
        key: _formKey,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
            child: Text("Get Recommendation of best Govt. Schemes",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey))),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Row(
                children: [
                  customTextField(
                      context: context,
                      controller: _phoneController,
                      hintText: formProvider.phoneNumber == null
                          ? "Enter your phone number"
                          : formProvider.phoneNumber.toString(),
                      labelText: "Phone Number",
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        formProvider.setPhoneNumber(value);
                      }),
                  FloatingActionButton(
                    onPressed:
                        // If not yet listening for speech start, otherwise stop
                        _speechToText.isNotListening
                            ? _startListeningPhone
                            : _stopListening,
                    tooltip: 'Listen',
                    child: Icon(_speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic),
                  ),
                ],
              ),
              Row(
                children: [
                  customTextField(
                      context: context,
                      controller: _incomeController,
                      hintText: formProvider.phoneNumber == null
                          ? "Enter your annual salary"
                          : formProvider.income.toString(),
                      labelText: "Income",
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        formProvider.setIncome(value);
                      }),
                  FloatingActionButton(
                    onPressed: _speechToText.isNotListening
                        ? _startListeningIncome
                        : _stopListening,
                    tooltip: 'Listen',
                    child: Icon(_speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic),
                  )
                ],
              ),
              Row(
                children: [
                  customTextField(
                      context: context,
                      controller: _placeController,
                      hintText: formProvider.phoneNumber == null
                          ? "Village/Taluka/District"
                          : formProvider.place.toString(),
                      labelText: "Place",
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      onChanged: (value) {
                        formProvider.setPlace(value);
                      }),
                  FloatingActionButton(
                    onPressed:
                        // If not yet listening for speech start, otherwise stop
                        _speechToText.isNotListening
                            ? _startListeningLocation
                            : _stopListening,
                    tooltip: 'Listen',
                    child: Icon(_speechToText.isNotListening
                        ? Icons.mic_off
                        : Icons.mic),
                  ),
                ],
              ),
              
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Birth",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 0, 166, 36)))),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller:
                            _dobController, //editing controller of this TextField
                        decoration: InputDecoration(
                            //icon of text field
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            hintText: formProvider.dateOfBirth == null
                                ? "DOB"
                                : formProvider.dateOfBirth,
                            fillColor: Colors.white,
                            suffixIcon:
                                Icon(Icons.calendar_today) //label text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              _dobController.text = formattedDate;
                              formProvider.setDOB(formattedDate
                                  .toString()); //set output date to TextField value.
                            });
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              customDropDown(
                  context: context,
                  hintText: "Select your Gender",
                  labelText: "Gender",
                  onChanged: (value) {
                    formProvider.setGender(value);
                  },
                  items: genderOptions),
              
              

              
            ],
          ),
          
        ]),
      );
    });
  }
}
