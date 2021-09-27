import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

import 'menu/dialog_menu.dart';

class DragableButton extends StatefulWidget {
  @override
  _DragableButtonState createState() => _DragableButtonState();
}

class _DragableButtonState extends State<DragableButton> {
  @override
  Widget build(BuildContext context) {
    return DraggableCard(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 8,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.circle,
            color: Theme.of(context).cardColor,
          ),
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({required this.child});

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  var _dragAlignment = Alignment.centerRight;

  Animation<Alignment>? _animation;

  final _spring = const SpringDescription(
    mass: 10,
    stiffness: 1000,
    damping: 0.9,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller!.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );
    final simulation =
        SpringSimulation(_spring, 0, 0.0, _normalizeVelocity(velocity, size));

    _controller!.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation!.value));
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => DialogMenu(),
        );
      },
      onPanStart: (details) => _controller!.stop(canceled: true),
      onPanUpdate: (details) {
        setState(() {
          _dragAlignment += Alignment(
            details.delta.dx / (size.width / 2.2),
            details.delta.dy / (size.height / 2.2),
          );

          if (_dragAlignment.x > 1) {
            _dragAlignment = Alignment(
              1.0,
              _dragAlignment.y,
            );
          } else if (_dragAlignment.x < -1) {
            _dragAlignment = Alignment(
              -1.0,
              _dragAlignment.y,
            );
          }
          if (_dragAlignment.y > 1) {
            _dragAlignment = Alignment(
              _dragAlignment.x,
              1.0,
            );
          } else if (_dragAlignment.y < -1) {
            _dragAlignment = Alignment(
              _dragAlignment.x,
              -1.0,
            );
          }
        });
      },
      onPanEnd: (details) {
        _runAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: widget.child,
        ),
      ),
    );
  }
}
