import 'package:flutter/material.dart';

class ScheduleFilter extends StatefulWidget {
  final Function(String? value) onSelected;
  const ScheduleFilter({super.key, required this.onSelected});

  @override
  State<ScheduleFilter> createState() => _ScheduleFilterState();
}

class _ScheduleFilterState extends State<ScheduleFilter> {
  String selectedKey = "Tout";
  @override
  Widget build(BuildContext context) {
    List<String> keys = ["Tout", "Jour", "Sem", "Mois"];
    return Row(
      children: [
        for (int i = 0; i < keys.length; i++) ...[
          Container(
            height: 40.0,
            decoration: BoxDecoration(
              color: selectedKey == keys[i] ? Colors.indigo : Colors.white70,
              border: Border.all(color: Colors.indigo, width: .1),
              borderRadius: BorderRadius.horizontal(
                left: i == 0 ? const Radius.circular(4.0) : Radius.zero,
                right: i == keys.length - 1
                    ? const Radius.circular(4.0)
                    : Radius.zero,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.horizontal(
                left: i == 0 ? const Radius.circular(4.0) : Radius.zero,
                right: i == keys.length - 1
                    ? const Radius.circular(4.0)
                    : Radius.zero,
              ),
              child: InkWell(
                borderRadius: BorderRadius.horizontal(
                  left: i == 0 ? const Radius.circular(4.0) : Radius.zero,
                  right: i == keys.length - 1
                      ? const Radius.circular(4.0)
                      : Radius.zero,
                ),
                onTap: () {
                  selectedKey = keys[i];
                  widget.onSelected.call(keys[i]);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Text(
                      keys[i].toUpperCase(),
                      textScaleFactor: .8,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: selectedKey == keys[i]
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]
      ],
    );
  }
}
