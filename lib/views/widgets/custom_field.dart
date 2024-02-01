import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? hintText;
  final String? trailing;
  final TextInputType? customInputType;
  const CustomField({
    super.key,
    required this.controller,
    required this.title,
    this.hintText,
    this.trailing,
    this.customInputType,
  });

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Colors.indigo,
              fontSize: 12.0,
            ),
          ),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: controller,
                      keyboardType: customInputType ?? TextInputType.text,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: hintText!,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                          fontStyle: FontStyle.italic,
                        ),
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        fillColor: Colors.transparent,
                      ),
                    ),
                  ),
                  if (trailing != null) ...[
                    Container(
                      height: 5.0,
                      width: 2.0,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    Text(
                      trailing!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    )
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
