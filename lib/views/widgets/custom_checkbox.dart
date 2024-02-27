import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final String? title;
  final bool isChecked;
  final VoidCallback? onChecked;
  const CustomCheckbox(
      {super.key, this.title, this.isChecked = false, this.onChecked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChecked!,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 25.0,
            width: 25.0,
            margin: const EdgeInsets.only(right: 5.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: isChecked ? Colors.blue.shade300 : Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: isChecked
                ? ZoomIn(
                    child: Container(
                      margin: const EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Colors.white,
                            size: 15.0,
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Text(
            title!,
            textScaleFactor: .9,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isChecked ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
