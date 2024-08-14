import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homeScreen.dart';

class OtpScreen extends StatefulWidget {
  String verificationid;
  OtpScreen({super.key, required this.verificationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    TextEditingController otpController = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xff78ab83),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter the otp here"),

            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 130),
              child: TextFormField(
                controller: otpController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4)
                ],
                style: TextStyle(color: Colors.purple,fontSize: 25),
                decoration: InputDecoration(
                  hintText: "Enter the OTP",
                  suffixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: List.generate(6, (index) {
            //     return SizedBox(
            //       width: 50,
            //       child:
            //       TextFormField(
            //         controller: otpController,
            //         keyboardType: TextInputType.number,
            //         inputFormatters: <TextInputFormatter>[
            //           FilteringTextInputFormatter.digitsOnly,
            //           LengthLimitingTextInputFormatter(6),
            //         ],
            //         textAlign: TextAlign.center,
            //         decoration: InputDecoration(
            //           border: OutlineInputBorder(),
            //         ),
            //       ),
            //     );
            //   }),
            // ),

            SizedBox(
              height: 10,
            ),

            ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                            verificationId: widget.verificationid,
                            smsCode: otpController.text.toString());
                    FirebaseAuth.instance.signInWithCredential(credential).then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                    });
                  } catch (ex) {
                    print(ex.toString());
                  }
                },
                child: Text("OTP"))

            // IconButton.filledTonal(
            //     onPressed: () {
            //
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
            // }, icon: Icon(Icons.done_outline_sharp,color: Colors.green,))
          ],
        ),
      ),
    );
  }
}
