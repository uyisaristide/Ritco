import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ritco_app/riverpod/providers/auth_providers.dart';

import '../../constants/_assets.dart';
import '../../utls/styles.dart';
import 'widgets/input_dec.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  var key = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    return Scaffold(
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.all(20)
              .copyWith(top: MediaQuery.of(context).padding.top),
          children: [
            Image.asset(
              AssetsUtils.logo,
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),

            const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: phoneController,
                validator: (s) => (s?.trim().length ?? 0) >= 10
                    ? null
                    : 'Telephone has to be at least 10 digits',
                decoration: iDecoration(
                  hint: "Telephone",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextFormField(
                  controller: passwordController,
                  validator: (s) => s?.trim().isNotEmpty == true
                      ? null
                      : 'Password is required',
                  decoration: iDecoration(hint: "Password"),
                  obscureText: true),
            ),
            user!.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: StyleUtls.buttonStyle,
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(userProvider.notifier).login(context, ref,
                            phoneController.text, passwordController.text);
                      }
                      // context.go('/home');
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    context.go("/forgetPassword");
                  },
                  child: const Text("Forgot Password ?")),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "OR",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            OutlinedButton(
                style: StyleUtls.textButtonStyle,
                onPressed: () {
                  context.go('/newUser');
                  // Navigator.push(
                  //     context,
                  //     CupertinoPageRoute(
                  //         builder: (context) => const Registration()));
                },
                child: const Text("Register")),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextButton(onPressed: (){
            //     Navigator.push(context, CupertinoPageRoute(builder: (context)=>const CustomerHomepage()));
            //   }, child: const Text("Continue as guest")),
            // )
          ],
        ),
      ),
    );
  }
}
