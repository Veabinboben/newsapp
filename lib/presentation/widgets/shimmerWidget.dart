

import 'package:flutter/material.dart';

class ShimmerWidget extends StatefulWidget {
  @override
  _ShimmerWidgetState createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: 200,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              gradient: LinearGradient(
                transform: GradientRotation(1),
                begin: Alignment(-1.0 + _animation.value, 0),
                end: Alignment(1.0 + _animation.value, 0),
                colors: [Colors.grey, Colors.white, Colors.grey],
              ),
            ),
          );
        },
      ),
    );
  }
}