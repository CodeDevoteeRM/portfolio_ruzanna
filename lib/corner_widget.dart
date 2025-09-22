import 'package:flutter/material.dart';
import 'constants.dart';

class CornerWidget extends StatefulWidget {
  final String text;
  final Alignment alignment;
  final bool inverted;
  final double cornerRadius;

  const CornerWidget({
    super.key,
    required this.text,
    required this.alignment,
    this.inverted = false,
    this.cornerRadius = 20.0,
  });

  @override
  State<CornerWidget> createState() => _CornerWidgetState();
}

class _CornerWidgetState extends State<CornerWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _getBorderRadius(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.cherry,
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    if (widget.inverted) {
      switch (widget.alignment) {
        case Alignment.topLeft:
          return BorderRadius.only(
            bottomRight: Radius.circular(widget.cornerRadius),
          );
        case Alignment.topRight:
          return BorderRadius.only(
            bottomLeft: Radius.circular(widget.cornerRadius),
          );
        case Alignment.bottomLeft:
          return BorderRadius.only(
            topRight: Radius.circular(widget.cornerRadius),
          );
        case Alignment.bottomRight:
          return BorderRadius.only(
            topLeft: Radius.circular(widget.cornerRadius),
          );
        default:
          return BorderRadius.circular(widget.cornerRadius);
      }
    } else {
      switch (widget.alignment) {
        case Alignment.topLeft:
          return BorderRadius.only(
            topLeft: Radius.circular(widget.cornerRadius),
          );
        case Alignment.topRight:
          return BorderRadius.only(
            topRight: Radius.circular(widget.cornerRadius),
          );
        case Alignment.bottomLeft:
          return BorderRadius.only(
            bottomLeft: Radius.circular(widget.cornerRadius),
          );
        case Alignment.bottomRight:
          return BorderRadius.only(
            bottomRight: Radius.circular(widget.cornerRadius),
          );
        default:
          return BorderRadius.circular(widget.cornerRadius);
      }
    }
  }
}