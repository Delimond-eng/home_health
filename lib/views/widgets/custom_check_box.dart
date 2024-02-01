import 'package:flutter/material.dart';

class CostumCheckBox extends StatelessWidget {
  final Function onChanged;
  final bool value;
  final String title;
  const CostumCheckBox({
    super.key,
    required this.onChanged,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 3,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(5.0),
          onTap: () => onChanged(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.indigo,
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.3),
                        blurRadius: 12.0,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      gradient: (value)
                          // ignore: dead_code
                          ? LinearGradient(
                              colors: [
                                Colors.indigo.shade300,
                                Colors.indigo,
                              ],
                            )
                          : const LinearGradient(
                              colors: [
                                Colors.white,
                                Colors.white,
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Colors.indigo.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
