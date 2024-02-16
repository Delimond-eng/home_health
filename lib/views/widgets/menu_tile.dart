import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final MaterialColor color;
  final IconData icon;
  final String title;
  final String? description;
  final Function onPressed;
  const MenuTile({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        image: const DecorationImage(
          image: AssetImage("assets/imgs/shape-bg-1.jpg"),
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: LinearGradient(colors: [
            color,
            color.shade300.withOpacity(.8),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.3),
              blurRadius: 10.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5.0),
            onTap: () => onPressed(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
