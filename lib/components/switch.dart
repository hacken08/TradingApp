import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return InkWell(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 45.0,
            height: 28.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: _circleAnimation!.value == Alignment.centerLeft
                  ? Colors.grey
                  : Colors.blue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value
                    ? ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerRight
                        : Alignment.centerLeft)
                    : ((Directionality.of(context) == TextDirection.rtl)
                        ? Alignment.centerLeft
                        : Alignment.centerRight),
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MessageViewer extends HookConsumerWidget {
  final String message;
  final AlignmentGeometry messageAlign;
  final EdgeInsetsGeometry padding;
  final Color textColor;
  final Color boxColor;
  final UpperNipMessageClipperTwo messageType;
  const MessageViewer({
    super.key,
    required this.message,
    required this.messageType,
    required this.padding,
    required this.textColor,
    required this.boxColor,
    required this.messageAlign,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: padding,
      child: ClipPath(
        clipper: messageType,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
            decoration: BoxDecoration(
              color: boxColor,
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(fontSize: 17, color: textColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
