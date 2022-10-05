import 'package:flutter/material.dart';

class AuthDashboard extends StatelessWidget {
  const AuthDashboard({Key? key}) : super(key: key);
  static const routeName = 'authdashboard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('./assets/authpage_icon.png'),
              Wrap(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top:10.0, bottom:10.0),
                    child: Text(
                      "Get Reccomendation of best Govt. Schemes",
                      style: TextStyle(fontSize: 35),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                    ),
                    onPressed: () {},
                    child: Text("Sign Up")),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Login"),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 214, 214, 214)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.green)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
