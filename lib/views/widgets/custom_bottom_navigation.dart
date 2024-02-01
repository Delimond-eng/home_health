import 'package:flutter/material.dart';

class CostumBottomNavigationBar extends StatelessWidget {
  final Color selectedIconColor;
  final Color unSelectedIconColor;
  final MaterialColor selectedItemColor;
  final List<IconData> items;
  final int currentIndex;
  final Function(int index) onChanged;
  const CostumBottomNavigationBar({
    super.key,
    required this.selectedIconColor,
    required this.unSelectedIconColor,
    required this.currentIndex,
    required this.items,
    required this.onChanged,
    required this.selectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 10.0,
            offset: const Offset(0, 1),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < items.length; index++) ...[
                Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30.0),
                    child: InkWell(
                      onTap: () => onChanged(index),
                      borderRadius: BorderRadius.circular(30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              items[index],
                              color: index == currentIndex
                                  ? selectedIconColor
                                  : unSelectedIconColor,
                              size: 25.0,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: index == currentIndex ? 5 : 0,
                              width: index == currentIndex ? 18.0 : 0,
                              margin: const EdgeInsets.only(top: 5.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: index == currentIndex
                                      ? [
                                          selectedItemColor,
                                          selectedItemColor.shade200,
                                        ]
                                      : [
                                          Colors.transparent,
                                          Colors.transparent,
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ]),
      ),
    );
  }
}
