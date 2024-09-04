import 'package:backend_di/screens/login.dart';
import 'package:backend_di/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
          ),
          TextFormField(
            controller: pwdController,
          ),
          ElevatedButton(
              onPressed: () async {
                try {
                  isLoading = true;
                  setState(() {});
                  await AuthServices()
                      .registerUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) {
                    isLoading = false;
                    setState(() {});
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: isLoading ? CircularProgressIndicator() : Text("Register"))
        ],
      ),
    );
  }
}
