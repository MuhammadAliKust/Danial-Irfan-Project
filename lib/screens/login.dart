import 'package:backend_di/services/auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                  setState(() {

                  });
                  await AuthServices()
                      .loginUser(
                          email: emailController.text,
                          password: pwdController.text)
                      .then((val) {
                    isLoading = false;
                    setState(() {

                    });
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Logged In"),
                          );
                        });
                  });
                } catch (e) {
                  isLoading = false;
                  setState(() {

                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              child: isLoading ? CircularProgressIndicator() : Text("LOgin"))
        ],
      ),
    );
  }
}
