import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:iyojana/auth/widgets/custom_dropdown.dart';
import 'package:iyojana/auth/widgets/custom_text_field.dart';

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

  List<String> genderOptions = ["Male", "Female", "Rather not say"];
  List<String> maritalOptions = ["Single", "Married"];
  @override
  Widget build(BuildContext context) {
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //       decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           filled: true,
            //           fillColor:
            //               const Color.fromARGB(179, 208, 208, 208),
            //           hintText: "Email")),
            // ),
            // customTextField(
            //     context: context,
            //     controller: _emailController,
            //     hintText: "Enter your email",
            //     labelText: "Email",
            //     obscureText: false,
            //     keyboardType: TextInputType.emailAddress,
            //     onChanged: (value) {}),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //       decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           filled: true,
            //           fillColor:
            //               const Color.fromARGB(179, 208, 208, 208),
            //           hintText: "Name")),
            // ),
            customTextField(
                context: context,
                controller: _phoneController,
                hintText: "Enter your phone number",
                labelText: "Phone Number",
                obscureText: false,
                keyboardType: TextInputType.phone,
                onChanged: (value) {}),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //       keyboardType: TextInputType.number,
            //       decoration:
            //           Styles().inputDecoration(labelText: "Email")),
            // ),
            // customTextField(context: context, controller: _dobController, hintText: "DOB", labelText: "Date of Birth", obscureText: false, keyboardType: TextInputType.datetime, onChanged: onChanged)
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
                          hintText: "DOB",
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
                            _dobController.text =
                                formattedDate; //set output date to TextField value.
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //       //keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           filled: true,
            //           fillColor:
            //               const Color.fromARGB(179, 208, 208, 208),
            //           hintText: "Caste")),
            // ),
            // customTextField(context: context, controller: _genderController, hintText: "Select your gender", labelText: "Gender", obscureText: false, keyboardType: TextInputT, onChanged: onChanged)
            customDropDown(
                context: context,
                hintText: "Select your Gender",
                labelText: "Gender",
                onChanged: (value) {},
                items: genderOptions),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextFormField(
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           filled: true,
            //           fillColor:
            //               const Color.fromARGB(179, 208, 208, 208),
            //           hintText: "Age")),
            // ),
            customTextField(
                context: context,
                controller: _incomeController,
                hintText: "Enter your annual salary",
                labelText: "Income",
                obscureText: false,
                keyboardType: TextInputType.name,
                onChanged: (value) {}),

            customDropDown(
                context: context,
                hintText: "Select your Marital Status",
                labelText: "Marital Status",
                onChanged: (value) {},
                items: maritalOptions),
          ],
        ),
        //Expanded(child: Container()),
      ]),
    );
  }
}
