import 'package:flutter/material.dart';

///Custom elevalted button with loading indicator.
///
///See also:
///- `ElevatedButton()`
class CustomButton extends StatefulWidget {
  ///Button child.
  final Widget child;

  ///Callback triggered when the button is pressed for one time.
  final VoidCallback onPressed;

  ///When `true` a loading indicator shows and the button becomes not responding to touch.
  final bool isLoading;

  ///Looding indicator widget, shows when the `isLoading` property is `True`
  final Widget? progressIndicator;

  const CustomButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.isLoading = false,
    this.progressIndicator,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;

  @override
  void initState() {
    _isLoading = widget.isLoading;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomButton oldWidget) {
    if (widget.isLoading != oldWidget.isLoading) {
      setState(() => _isLoading = widget.isLoading);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_isLoading) return;
            widget.onPressed.call();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: widget.child,
          ),
        ),
        if (_isLoading) ...[
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.4),
            ),
          ),
          widget.progressIndicator ??
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              ),
        ]
      ],
    );
  }
}
