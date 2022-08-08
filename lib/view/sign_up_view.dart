import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revised_mobile_assignment/service/validator_mixin.dart';
import 'package:revised_mobile_assignment/view/animation/fade_animation.dart';

import '../constant/style.dart';
import '../widget/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with ValidatorMixin {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SYSTEM_OVERLAY_STYLE,
      child: Scaffold(
        backgroundColor: BACKGROUND_COLOR,
        body: GestureDetector(
          onTap: () {
            _unfocusTextField();
          },
          child: Container(
            height: double.maxFinite,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  BACKGROUND_COLOR,
                  Color(0xffcccbcd),
                ],
                stops: [0.1, 0.78],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Form(
              key: _formKey,
              child: SafeArea(
                child: LayoutBuilder(builder: (context, constraint) {
                  double width = 0.0;
                  if (constraint.maxWidth <= 540) {
                    width = constraint.maxWidth;
                  } else {
                    width = 540;
                  }
                  return SingleChildScrollView(
                    child: Center(
                      child: SizedBox(
                        width: width,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 580,
                              width: width,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: 380,
                                    width: width,
                                    child: Image.asset(
                                      "assets/images/happy_lancer.png",
                                      fit: BoxFit.fitHeight,
                                      color: BACKGROUND_COLOR.withOpacity(0.4),
                                      colorBlendMode: BlendMode.dstATop,
                                      cacheHeight: 580,
                                      height: 580,
                                    ),
                                  ),
                                  Positioned(
                                    top: -30,
                                    left: (580 * 0.60) - 580,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(300),
                                      child: Container(
                                        height: 580,
                                        width: 580,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xB36166C7),
                                              SECONDARY_COLOR,
                                              // Colors.red
                                            ],
                                            stops: [0.0, 0.78],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 70,
                                    left: 30,
                                    right: 30,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        FadeAnimation(
                                          delay: 1.0,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                    color: WHITE_COLOR,
                                                    fontSize: 36,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Sign up with your username or email",
                                                style: TextStyle(
                                                  color: Color(0xffe1e1e1),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 60),
                                        FadeAnimation(
                                          delay: 1.6,
                                          child: _buildLoginInputView(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 40,
                                    right: 30,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: ICON_COLOR,
                                              width: 2.4,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Forgot Password",
                                          style: TextStyle(
                                            color: TEXT_COLOR,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildSocialLoginView(),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginInputView() {
    const decoration = BoxDecoration(
      color: Color(0xddffffff),
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(left: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: decoration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomTextField(
                    validator: emailValidation,
                    controller: _email,
                    focusNode: _emailFocus,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Username or Email",
                  ),
                ),
                const Divider(
                  height: 2,
                  thickness: 1.5,
                  color: TEXT_COLOR2,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CustomTextField(
                    validator: passwordValidation,
                    controller: _password,
                    focusNode: _passwordFocus,
                    hintText: "Password",
                    obscureText: true,
                  ),
                ),
                const Divider(
                  height: 2,
                  color: TEXT_COLOR2,
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomTextField(
                    validator: (String? val) {
                      return confirmPasswordValidation(
                        confirmPassword: val?.trim(),
                        password: _password.text.trim(),
                      );
                    },
                    controller: _confirmPassword,
                    focusNode: _confirmPasswordFocus,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: BLACK_COLOR,
              fixedSize: const Size(160, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _unfocusTextField();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.teal,
                    content: Text("User successfully sign up"),
                  ),
                );
              }
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: TEXT_COLOR2,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildSocialLoginView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            "Social login can save your valuable time",
            style: TextStyle(
              color: TEXT_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: Divider(
                  thickness: 3,
                  color: ICON_COLOR,
                  endIndent: 16,
                ),
              ),
              SvgPicture.asset(
                "assets/svg/hand.svg",
                color: ICON_COLOR,
                height: 25,
                width: 25,
              ),
              const Flexible(
                child: Divider(
                  color: ICON_COLOR,
                  thickness: 3,
                  indent: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: WHITE_COLOR,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: ICON_COLOR, width: 1.5),
                  ),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SvgPicture.asset(
                        "assets/svg/google.svg",
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Google",
                        style: TextStyle(
                          color: TEXT_COLOR,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 60),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  decoration: BoxDecoration(
                    color: BUTTON_COLOR,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/facebook.svg",
                        color: WHITE_COLOR,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "Facebook",
                        style: TextStyle(
                          color: WHITE_COLOR,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _unfocusTextField() {
    _emailFocus.unfocus();
    _passwordFocus.unfocus();
    _confirmPasswordFocus.unfocus();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
  }
}
