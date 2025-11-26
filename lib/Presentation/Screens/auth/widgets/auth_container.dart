import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final List<Widget> children;
  final double? heightFactor;

  const AuthContainer({
    super.key,
    required this.children,
    this.heightFactor = 0.45,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      width: MediaQuery.of(context).size.width * 0.90,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * heightFactor!,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: children),
      ),
    );
  }
}
