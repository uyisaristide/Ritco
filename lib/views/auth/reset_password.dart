import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/_assets.dart';
import '../../utls/styles.dart';
import 'widgets/input_dec.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen>  {
  final TextEditingController _usernameController = TextEditingController();

  bool _loading = false;

  final _form = GlobalKey<FormState>();

  // Future<void> sendCode() async {
  //   if (_form.currentState?.validate() ?? false) {
  //     setState(() {
  //       _loading = true;
  //     });
  //     await ajax(
  //         url: "reset_password/verify",
  //         method: "POST",
  //         data: FormData.fromMap({
  //           "user_phone": widget.phone,
  //           "code": _usernameController.text,
  //         }),
  //         onValue: (obj, url) {
  //           if (obj['code'] == 200) {
  //             var user = User.fromJson(obj['data']);
  //             push(NewPassword(user: user));
  //           } else {
  //             showSnack(obj['message']);
  //           }
  //         },
  //         error: (s, v) => showSnack("$s"));
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(20)
              .copyWith(top: MediaQuery.of(context).padding.top),
          children: [
            Image.asset(AssetsUtils.logo,height: 150,),
            // Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Image.asset(AssetsUtils.logo),
            // ),
            const SizedBox(height: 30,),

            const Text(
              "Password reset code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            // Center(
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 20),
            //       child: Text(
            //         "Password reset code",
            //         style: Theme.of(context).textTheme.bodyLarge,
            //       ),
            //     )),
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Kindly fill the password reset code we have sent To your phone number",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextFormField(
                decoration: iDecoration(hint: "Your Code"),
                controller: _usernameController,
                validator: (s) =>
                s?.trim().isNotEmpty == true ? null : "Field is required !",
              ),
            ),
            _loading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                :ElevatedButton(
              style: StyleUtls.buttonStyle,
              onPressed: (){
                context.go('/newPassword');
              },
              child: const Text(
                "Reset password",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: OutlinedButton(onPressed: () =>context.go('/login'),style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  foregroundColor: Colors.red
              ), child: const Text("Cancel")),
            )
          ],
        ),
      ),
    );
  }
}
