import 'dart:math' as math;

import 'package:unit/unit.dart';

void main() {
  var halfCircle = Angle(math.pi);
  var rightAngle = Angle.fromDeg(90);

  print('This is 270 degrees: ${(halfCircle + rightAngle).deg}');
}
