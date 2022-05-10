import 'package:flutter/material.dart';
import 'package:needs_customer/controller/auth_controller.dart';

import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

    var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        const BackGroundGradient(),
        SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: size.height * 0.3,
                  image: const AssetImage('assets/img/logo.png'),
                ),
                const SizedBox(height: 30),
                TransparentFormField(
                  controller: emailController,
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  isEmail: true,
                  isPassword: false,
                ),
                const SizedBox(height: 10),
                TransparentFormField(
                  controller: passwordController,
                  hintText: "Password",
                  icon: Icons.key_outlined,
                  isEmail: false,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ButtonTransparent(
                  string: "Crea tú cuenta",
                  width: 2.58,
                  voidCallback: () {
                    AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());
                  },
                ),
                const SizedBox(height: 20),
                
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "¿Ya tienes una cuenta?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
