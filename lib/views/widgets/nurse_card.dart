import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/nurse.dart';

class NurseCard extends StatelessWidget {
  final bool isLast;
  final Nurse item;
  const NurseCard({
    super.key,
    this.isLast = false,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        title: Text(item.nurseFullname!),
        subtitle: const Text("Infirmier"),
        leading: Container(
          height: 35.0,
          width: 35.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.indigo.shade300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/profile.svg",
                height: 22.0,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ],
          ),
        ),
        trailing: SvgPicture.asset(
          "assets/svg/more.svg",
          height: 26,
          colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        ),
      ),
    );
  }
}
