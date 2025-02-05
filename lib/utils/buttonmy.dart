import 'package:flutter/material.dart';

class StylishButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const StylishButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff6A0DAD), // Purple color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        elevation: 5, // Shadow effect
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white, // Text color
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
