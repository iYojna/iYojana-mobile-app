import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iyojana/auth/widgets/custom_dropdown.dart';
import 'package:iyojana/auth/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../styles.dart';
import '../form_provider.dart';
import 'custom_elevated_button.dart';

class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2({Key? key}) : super(key: key);

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _casteController = TextEditingController();
  final TextEditingController _educationalController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  List<String> maritalOptions = ["Single", "Married"];
  List<String> casteOptions = ["General", "OBC", "SC", "ST"];
  List<String> educationalOptions = [
    "Below 10th",
    "10th",
    "12th",
    "Graduate",
    "Post Graduate",
    "Doctorate"
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<FormProvider>(
      builder: (context, formProvider, _) => 
      Form(
        //key: _formKey,
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
            children: [
              customDropDown(
                  context: context,
                  hintText: "Select your Caste",
                  labelText: "Caste",
                  onChanged: (value) {
                    formProvider.setCaste(value);
                  },
                  items: casteOptions),
              
              customDropDown(
                  context: context,
                  hintText: "Select your educational qualifications",
                  labelText: "Educational Qualifications",
                  onChanged: (value) {
                    formProvider.setEdquality(value);
                  },
                  items: educationalOptions),
              customDropDown(
                  context: context,
                  hintText: "Select your Marital Status",
                  labelText: "Marital Status",
                  onChanged: (value) {
                    formProvider.setMaritalStatus(value);
                  },
                  items: maritalOptions),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Log In',
                          style: const TextStyle(color: Colors.green),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              //TODO : Add Sign up screen route
                              print('Sign Up');
                            }),
                    ],
                  ),
                ),
              ),
              customElevatedButton(
                  context: context,
                  onPressed: () {
                    print(formProvider.caste);
                    print(formProvider.dateOfBirth);
                    print(formProvider.caste);
                    print(formProvider.gender);
                  },
                  content: "Sign Up",
                  style: Styles().buttonStyle1())
            ],
          ),
          //Expanded(child: Container()),
        ]),
      ),
    );
  }
}
