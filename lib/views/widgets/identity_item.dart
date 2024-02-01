import 'package:flutter/material.dart';

class IdentityItem extends StatelessWidget {
  final String title, value;
  const IdentityItem({super.key, required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                    fontSize: 8.0,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.indigo.shade900,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                colors: [
                  Colors.indigo,
                  Colors.indigo.shade100,
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
