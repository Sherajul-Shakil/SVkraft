import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _codeController = TextEditingController();
Future loginUser(String phone, BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  _auth.verifyPhoneNumber(
    phoneNumber: phone,
    timeout: const Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential credential) async {
      Navigator.of(context).pop();

      UserCredential result = await _auth.signInWithCredential(credential);

      if (result.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomAppBar(
                    // user: result.user,
                    )));
      } else {
        print("Error");
      }

      //This callback would gets called when verification is done auto maticlly
    },
    verificationFailed: (Exception exception) {
      print(exception);
    },
    codeSent: (String verificationId, int? resendToken) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Insert the code?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                    keyboardType:
                        const TextInputType.numberWithOptions(signed: true),
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text("Confirm"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    // String comingSms = (await AltSmsAutofill().listenForSms)!;
                    // String aStr =
                    //     comingSms.replaceAll(new RegExp(r'[^0-9]'), '');
                    // String otp = aStr.substring(0, 6);

                    // final code = otp;
                    // print(comingSms);
                    final code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: code);

                    UserCredential result =
                        await _auth.signInWithCredential(credential);

                    if (result.user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomAppBar(
                                  // user: result.user,
                                  )));
                    } else {
                      print("Error");
                    }
                  },
                )
              ],
            );
          });
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print('Time Out');
    },
  );
}
