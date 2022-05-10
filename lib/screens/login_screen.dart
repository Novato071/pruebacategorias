import 'package:flutter/material.dart';
import 'package:needs_customer/controller/auth_controller.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonTransparent(
                      string: "Iniciar Sesión",
                      width: 2.58,
                      voidCallback: () {
                        AuthController.instance.login(
                            emailController.text.trim(),
                            passwordController.text.trim());
                      },
                    ),
                    SizedBox(width: size.width / 20),
                    ButtonTransparent(
                      string: "¿Olvido la Contraseña?",
                      width: 2.58,
                      voidCallback: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Image(
                        image: AssetImage("assets/img/logo-google.png"),
                      ),
                      iconSize: 70,
                      onPressed: () {
                        AuthController.instance.signInWithGoogle();
                      },
                    ),
                    const SizedBox(width: 50),
                    IconButton(
                      icon: const Image(
                        image: AssetImage("assets/img/logo-twitter.png"),
                      ),
                      iconSize: 70,
                      onPressed: () {
                        AuthController.instance.signInWithTwitter();
                      },
                    )
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  child: const Text(
                    "¿No tienes una cuenta?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
