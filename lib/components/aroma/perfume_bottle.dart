import 'package:flutter/material.dart';

enum BottleShape { classic, tapered, square }

/// A perfume bottle drawn in code: cap, neck and a glass body holding
/// [liquid]. Solid shapes only, no gradient shaders.
class PerfumeBottle extends StatelessWidget {
  const PerfumeBottle({
    super.key,
    required this.liquid,
    this.shape = BottleShape.classic,
  });

  final Color liquid;
  final BottleShape shape;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.62,
      child: CustomPaint(painter: _BottlePainter(liquid, shape)),
    );
  }
}

class _Proportions {
  const _Proportions({
    required this.capWidth,
    required this.capHeight,
    required this.bodyTop,
    required this.bodyBottom,
    required this.radius,
  });

  /// All as fractions of the bottle's width or height.
  final double capWidth;
  final double capHeight;
  final double bodyTop;
  final double bodyBottom;
  final double radius;
}

const _proportions = {
  BottleShape.classic: _Proportions(
    capWidth: 0.36,
    capHeight: 0.2,
    bodyTop: 0.88,
    bodyBottom: 0.88,
    radius: 0.12,
  ),
  BottleShape.tapered: _Proportions(
    capWidth: 0.32,
    capHeight: 0.22,
    bodyTop: 0.96,
    bodyBottom: 0.72,
    radius: 0.08,
  ),
  BottleShape.square: _Proportions(
    capWidth: 0.44,
    capHeight: 0.17,
    bodyTop: 0.82,
    bodyBottom: 0.82,
    radius: 0.07,
  ),
};

class _BottlePainter extends CustomPainter {
  _BottlePainter(this.liquid, this.shape);

  final Color liquid;
  final BottleShape shape;

  static const _silver = Color(0xFFD9DBE3);
  static const _silverDark = Color(0xFFA5A8B6);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final p = _proportions[shape]!;
    final paint = Paint()..isAntiAlias = true;

    final capBottom = h * p.capHeight;
    final collarBottom = capBottom + h * 0.045;
    final neckBottom = collarBottom + h * 0.05;
    final bodyBottom = h * 0.96;

    // Shadow on the ground.
    paint.color = const Color(0x22000000);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, bodyBottom),
        width: w * p.bodyBottom * 0.95,
        height: h * 0.05,
      ),
      paint,
    );

    // Body: glass edge, then the liquid inside it.
    final body = _roundedQuad([
      Offset(cx - w * p.bodyTop / 2, neckBottom),
      Offset(cx + w * p.bodyTop / 2, neckBottom),
      Offset(cx + w * p.bodyBottom / 2, bodyBottom),
      Offset(cx - w * p.bodyBottom / 2, bodyBottom),
    ], w * p.radius);
    paint.color = Color.lerp(liquid, Colors.white, 0.55)!;
    canvas.drawPath(body, paint);

    canvas.save();
    canvas.clipPath(body);
    final bodyHeight = bodyBottom - neckBottom;
    final inset = w * 0.05;
    final liquidPath = _roundedQuad([
      Offset(cx - w * p.bodyTop / 2 + inset, neckBottom + bodyHeight * 0.1),
      Offset(cx + w * p.bodyTop / 2 - inset, neckBottom + bodyHeight * 0.1),
      Offset(cx + w * p.bodyBottom / 2 - inset, bodyBottom - bodyHeight * 0.1),
      Offset(cx - w * p.bodyBottom / 2 + inset, bodyBottom - bodyHeight * 0.1),
    ], w * p.radius * 0.7);
    paint.color = liquid;
    canvas.drawPath(liquidPath, paint);

    // Darker right side and two light reflections on the left.
    paint.color = const Color(0x1A000000);
    canvas.drawRect(
      Rect.fromLTRB(cx + w * 0.18, neckBottom, w, bodyBottom),
      paint,
    );
    paint.color = const Color(0x8CFFFFFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          cx - w * p.bodyBottom / 2 + w * 0.1,
          neckBottom + bodyHeight * 0.16,
          w * 0.06,
          bodyHeight * 0.62,
        ),
        Radius.circular(w * 0.03),
      ),
      paint,
    );
    paint.color = const Color(0x4DFFFFFF);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          cx - w * p.bodyBottom / 2 + w * 0.2,
          neckBottom + bodyHeight * 0.2,
          w * 0.025,
          bodyHeight * 0.4,
        ),
        Radius.circular(w * 0.015),
      ),
      paint,
    );
    canvas.restore();

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.012
      ..color = Color.lerp(liquid, Colors.black, 0.2)!.withValues(alpha: 0.5);
    canvas.drawPath(body, paint);
    paint.style = PaintingStyle.fill;

    // Neck.
    paint.color = Color.lerp(liquid, Colors.white, 0.35)!;
    canvas.drawRect(
      Rect.fromLTRB(
        cx - w * 0.11,
        collarBottom - 1,
        cx + w * 0.11,
        neckBottom + 1,
      ),
      paint,
    );

    // Collar and cap.
    paint.color = _silverDark;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          cx - w * p.capWidth * 0.42,
          capBottom - h * 0.01,
          cx + w * p.capWidth * 0.42,
          collarBottom,
        ),
        Radius.circular(w * 0.02),
      ),
      paint,
    );
    final cap = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        cx - w * p.capWidth / 2,
        h * 0.01,
        cx + w * p.capWidth / 2,
        capBottom,
      ),
      Radius.circular(w * 0.05),
    );
    paint.color = _silver;
    canvas.drawRRect(cap, paint);
    canvas.save();
    canvas.clipRRect(cap);
    paint.color = _silverDark;
    canvas.drawRect(
      Rect.fromLTRB(cx + w * p.capWidth * 0.18, 0, cx + w, capBottom),
      paint,
    );
    paint.color = const Color(0xB3FFFFFF);
    canvas.drawRect(
      Rect.fromLTWH(cx - w * p.capWidth * 0.32, 0, w * 0.04, capBottom),
      paint,
    );
    canvas.restore();
  }

  /// Four-sided path with each corner rounded by [r].
  static Path _roundedQuad(List<Offset> pts, double r) {
    final path = Path();
    for (var i = 0; i < pts.length; i++) {
      final prev = pts[(i - 1 + pts.length) % pts.length];
      final curr = pts[i];
      final next = pts[(i + 1) % pts.length];
      final a = curr + _toward(curr, prev, r);
      final b = curr + _toward(curr, next, r);
      if (i == 0) {
        path.moveTo(a.dx, a.dy);
      } else {
        path.lineTo(a.dx, a.dy);
      }
      path.quadraticBezierTo(curr.dx, curr.dy, b.dx, b.dy);
    }
    return path..close();
  }

  static Offset _toward(Offset from, Offset to, double distance) {
    final d = to - from;
    return d / d.distance * distance;
  }

  @override
  bool shouldRepaint(_BottlePainter oldDelegate) =>
      oldDelegate.liquid != liquid || oldDelegate.shape != shape;
}
