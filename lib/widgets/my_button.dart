import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool disabled;

  MyButton({
    required this.title,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? .4 : 1,
      child: Container(
        height: 45,
        child: Material(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            highlightColor: disabled ? Colors.transparent : null,
            splashColor: disabled ? Colors.transparent : null,
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
