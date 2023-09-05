import 'package:email_otp/email_otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

import '../../common/theme_helper.dart';
import '../../logic/categry_logic.dart';
import '../../logic/expense_logic.dart';
import '../../logic/signin_logic.dart';
import '../../model/signin_model.dart';
import '../../logic/token.dart';

import '../Page_Controller.dart';
import 'widgets/header_widget.dart';

class VerificationPage extends StatefulWidget {
  Signin user;
   VerificationPage(this.user);
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final _formKey = GlobalKey<FormState>();
  String otpPin = "";
  final bool _pinSuccess = false;
  TextEditingController email = TextEditingController();
  TextEditingController otp = TextEditingController();
 EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    double headerHeight = 300;
    OtpFieldController optField = OtpFieldController();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: headerHeight,
                    child: HeaderWidget(
                        headerHeight, true, Icons.privacy_tip_outlined),
                  ),
                  SafeArea(
                    child: Container(
                      margin:  EdgeInsets.fromLTRB(25, 10, 25, 10),
                      padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            margin:  EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  'Verification',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  // textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Enter the verification code we just sent you on your email address.',
                                  style: TextStyle(
                                      // fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                  // textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                           SizedBox(height: 40.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                OTPTextField(
                                  controller: optField,
                                  length: 4,
                                  width: 350,
                                  fieldWidth: 50,
                                  style:  TextStyle(fontSize: 30),
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldStyle: FieldStyle.underline,
                                  onCompleted: (pin) {
                                    setState(() {
                                      otpPin = pin;
                                    });
                                  },
                                ),
                                 SizedBox(height: 50.0),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "If you didn't receive a code! ",
                                        style: TextStyle(
                                          color: Colors.black38,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Resend',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            myauth.setConfig(
                                              appEmail: "me@rohitchouhan.com",
                                              appName: "Email OTP",
                                              userEmail: widget.user.uGmail,
                                              otpType:OTPType.digitsOnly ,
                                              otpLength: 4,
                                            );
                                            if (await myauth.sendOTP() ==
                                                true) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content:
                                                    Text("OTP has been sent"),
                                              ));
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Oops, OTP send failed"),
                                              ));
                                            }
                                          },
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                                 SizedBox(height: 40.0),
                                Container(
                                  decoration: _pinSuccess
                                      ? ThemeHelper()
                                          .buttonBoxDecoration(context)
                                      : ThemeHelper().buttonBoxDecoration(
                                          context, "#AAAAAA", "#757575"),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding:  EdgeInsets.fromLTRB(
                                          40, 10, 40, 10),
                                      child: Text(
                                        "Verify".toUpperCase(),
                                        style:  TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (await myauth.verifyOTP(otp: otpPin) ==
                                          true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar( SnackBar(
                                          content: Text("OTP is verified"),
                                        ));
                                        String sigin = await context
                                            .read<SigninLogic>()  
                                            .sigin(widget.user);

                                        if (sigin.isNotEmpty) {
                                          context.read<Token>().setToken(sigin);
         context
                                              .read<ExpenseLogic>()
                                              .setToken(sigin);
                                          context
                                              .read<CategoryLogic>()
                                              .setToken(sigin);
                                          await context
                                              .read<ExpenseLogic>()
                                              .readexp();
                                          await context
                                              .read<CategoryLogic>()
                                              .readCate();
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainController(widget.user.uGmail)),
                                                  (route) => false);
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar( SnackBar(
                                          content: Text("Invalid OTP"),
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    icon:  Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          ),
        ));
  }
}
