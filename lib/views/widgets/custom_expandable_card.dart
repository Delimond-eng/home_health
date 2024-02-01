import 'dart:math';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomExpandableCard extends StatelessWidget {
  final String title;
  const CustomExpandableCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                fadeCurve: Curves.bounceIn,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.medical_information_outlined,
                              color: color.shade800,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        ExpandableIcon(
                          theme: const ExpandableThemeData(
                            expandIcon: CupertinoIcons.chevron_forward,
                            collapseIcon: CupertinoIcons.chevron_down,
                            iconColor: Colors.black,
                            iconSize: 20.0,
                            iconRotationAngle: math.pi / 2,
                            hasIcon: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              collapsed: Container(),
              expanded: Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(5.0),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Aucun antécedent",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
