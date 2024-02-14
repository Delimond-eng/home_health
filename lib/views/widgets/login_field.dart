import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final String icon;
  final bool isPassword;
  final TextEditingController? controller;
  const LoginField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isObscur = true;
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: StatefulBuilder(builder: (context, setter) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/svg/$icon.svg",
                      height: 18.0,
                      colorFilter: const ColorFilter.mode(
                          Colors.indigo, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 5.0),
                    if (isPassword) ...[
                      Flexible(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: hintText,
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            counterText: '',
                          ),
                          obscureText: isObscur,
                        ),
                      )
                    ] else ...[
                      Flexible(
                        child: TextField(
                          controller: controller,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: hintText,
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                            counterText: '',
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
              if (isPassword) ...[
                GestureDetector(
                  onTap: () {
                    setter(() {
                      isObscur = !isObscur;
                    });
                  },
                  child: SvgPicture.asset(
                    !isObscur
                        ? "assets/svg/eye-slash-alt.svg"
                        : "assets/svg/eye-alt.svg",
                    height: 20.0,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                )
              ]
            ],
          );
        }),
      ),
    );
  }
}
