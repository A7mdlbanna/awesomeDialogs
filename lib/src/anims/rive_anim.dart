import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAssetAnimation extends StatefulWidget {
  const RiveAssetAnimation({
    super.key,
    required this.assetPath,
    required this.animName,
  });

  final String assetPath;
  final String animName;

  @override
  State<RiveAssetAnimation> createState() => _RiveAssetAnimationState();
}

class _RiveAssetAnimationState extends State<RiveAssetAnimation> {
  File? _file;
  Artboard? _artboard;
  late SingleAnimationPainter _painter;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final file = await File.asset(
      widget.assetPath,
      riveFactory: Factory.rive,
    );

    final artboard = file!.defaultArtboard();

    _painter = SingleAnimationPainter(widget.animName);

    setState(() {
      _file = file;
      _artboard = artboard;
    });
  }

  @override
  void dispose() {
    _painter.dispose();
    _artboard?.dispose();
    _file?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_artboard == null) {
      return const SizedBox();
    }

    return RiveArtboardWidget(
      artboard: _artboard!,
      painter: _painter,
    );
  }
}