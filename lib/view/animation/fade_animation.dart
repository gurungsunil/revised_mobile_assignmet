import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatefulWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> {
  final MultiTween tween = MultiTween();
  var control = CustomAnimationControl.play;

  @override
  void initState() {
    super.initState();
    tween.add(
      "opacity",
      Tween(begin: 0.0, end: 1.0),
      const Duration(milliseconds: 500),
    );
    tween.add(
      "translateY",
      Tween(begin: -30.0, end: 0.0),
      const Duration(milliseconds: 500),
      Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomAnimation(
      delay: Duration(milliseconds: (500 * widget.delay).round()),
      duration: tween.duration,
      control: control,
      tween: tween,
      builder: (context, child, MultiTweenValues<dynamic> value) {
        return Opacity(
          opacity: value.get("opacity"),
          child: Transform.translate(
            offset: Offset(0, value.get("translateY")),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
