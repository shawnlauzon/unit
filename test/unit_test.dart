// License: MIT
import 'dart:math' as math;

import 'package:test/test.dart';

import 'package:unit/unit.dart';

void main() {
  group('Function tests', () {
    test('ExampleFromSexa', () {
      // Typical usage:  non-negative d, m, s, and '-' to indicate negative:
      expect(fromSexa('-', 20, 30, 0), -20.5);
      // Putting the minus sign on d is not equivalent:
      expect(fromSexa(' ', -20, 30, 0), -19.5);

      // Other combinations can give the same result though:
      expect(fromSexa(' ', -20, -30, 0), -20.5);
      expect(fromSexa(' ', -21, 30, 0), -20.5);
      expect(fromSexa(' ', -22, 90, 0), -20.5);
      expect(fromSexa('-', 22, -90, 0), -20.5);
    });

    test('ExampleFromSexaSec', () {
      expect(3600, fromSexaSec(' ', 1, 0, 0));
    });

    // Test which shows that the Dart modulo (%) operator is the same as
    // the original Go PMod function.
    test('ExampleDartMod', () {
      expect(5 % 3, 2);
      expect(-5 % 3, 1);
      expect(-2.5 % 360, 357.5);

      // A more typical use:
      expect(-2.5 % 360, 357.5);
      // Output:
      //  x      y     x % y   PMod(x, y);
      //  5      3       2          2.0
      // -5      3      -2          1.0
      // -2.5  360                357.5
    });
  });

  group('Angle tests', () {
    test('ExampleAngle.fromDeg', () {
      final a = Angle.fromDeg(180);
      expect(a.rad, 3.141592653589793);
    });

    test('ExampleAngle.fromMin', () {
      final a = Angle.fromMin(83);
      expect(a.sec, closeTo(83 * 60, .000001));
    });

    test('ExampleAngle.fromSec', () {
      final a = Angle.fromSec(83);
      expect(a.sec, closeTo(83, .000001));
    });

    test('ExampleAngleFromSexa', () {
      expect(
          Angle.fromSexa('-', 0, 32, 41).min, closeTo(-32 - 41 / 60, 0.000001));
      expect(
          Angle.fromSexa(' ', 0, 32, 41).min, closeTo(32 + 41 / 60, 0.000001));
      expect(
          Angle.fromSexa('+', 0, 32, 41).min, closeTo(32 + 41 / 60, 0.000001));
      expect(Angle.fromSexa(0, 0, 32, 41).min, closeTo(32 + 41 / 60, 0.000001));
    });

    test('ExampleAngle_Cos', () {
      final a = Angle.fromDeg(60);
      expect(a.cos(), closeTo(0.500000, .000001));
    });

    test('ExampleAngle_Deg', () {
      final a = Angle(math.pi / 2);
      expect(a.deg, 90);
    });

    test('ExampleAngle_Div', () {
      final a = Angle.fromDeg(90);
      expect(a.div(2).deg, 45);
    });

    test('ExampleAngle_HourAngle', () {
      final a = Angle.fromDeg(-30);

      expect(a.hourAngle(), HourAngle.fromHour(2));
    });

    test('ExampleAngle_Min', () {
      final a = Angle.fromSexa(' ', 1, 23, 0);
      expect(a.min, closeTo(83, 0.000001));
    });

    test('ExampleAngle_Mod1', () {
      expect(Angle.fromDeg(23).mod1(), Angle.fromDeg(23));
      expect(Angle.fromDeg(383).mod1(), Angle.fromDeg(23));
      expect(Angle.fromDeg(-337).mod1(), Angle.fromDeg(23));
    });

    test('ExampleAngle_Mul', () {
      final a = Angle.fromDeg(45);
      expect(a.mul(2), Angle.fromDeg(90));
    });

    test('ExampleAngle_Rad', () {
      final a =
          Angle.fromSexa(' ', 180, 0, 0); // conversion to radians happens here
      expect(a.rad, 3.141592653589793); // no cost to access radians here
    });

    test('ExampleAngle_Sec', () {
      final a = Angle.fromSexa(' ', 0, 1, 23);
      expect(a.sec, closeTo(83.00000, 0.000001));
    });

    test('ExampleAngle_Sin', () {
      final a = Angle.fromDeg(60);
      expect(a.sin(), closeTo(0.866025, 0.000001));
    });

    test('ExampleAngle_Tan', () {
      final a = Angle.fromDeg(60);
      expect(a.tan(), closeTo(1.732051, 0.000001));
    });

    test('ExampleAngle_Time', () {
      final a = Angle.fromDeg(-30);
      expect(a, Angle.fromSexa(0, -30, 0, 0));
      expect(a.time(), Time.fromHour(-2));
    });
  });

  group('Hour Angle tests', () {
    test('ExampleHourAngle.fromHour', () {
      final h = HourAngle.fromHour(12);
      expect(h.rad, 3.141592653589793);
      expect(h.hour, 12);
      expect(HourAngle.fromHour(-2).hour, -2);
    });

    test('ExampleHourAngle.fromMin', () {
      expect(HourAngle.fromMin(-83), HourAngle.fromSexa('-', 1, 23, 0));
    });

    test('ExampleHourAngle.fromSec', () {
      expect(HourAngle.fromSec(-83), HourAngle.fromSexa('-', 0, 1, 23));
    });

    test('ExampleHourFromSexa', () {
      final h = HourAngle.fromSexa(' ', 0, 32, 41);
      expect(h.sec, closeTo(41 + 32 * 60, 0.00001));
    });

    test('ExampleHourAngle_Angle', () {
      final h = HourAngle.fromHour(-2);
      expect(h.angle(), Angle.fromDeg(-30));
    });

    test('ExampleHourAngle_Cos', () {
      final h = HourAngle.fromHour(4);
      expect(h.cos(), closeTo(0.5, 0.000001));
    });

    test('ExampleHourAngle_Hour', () {
      final h = HourAngle.fromSexa(' ', 1, 30, 0);
      expect(h.hour, 1.5);
    });

    test('ExampleHourAngle_Div', () {
      final h = HourAngle.fromHour(6);
      expect(h.div(2), HourAngle.fromHour(3));
    });

    test('ExampleHourAngle_Min', () {
      final h = HourAngle.fromSexa(' ', 1, 23, 0);
      expect(h.min, closeTo(83, 0.000001));
    });

    test('ExampleHourAngle_Mul', () {
      final h = HourAngle.fromHour(3);
      expect(h.mul(2), HourAngle.fromHour(6));
    });

    test('ExampleHourAngle_Rad', () {
      final a = HourAngle.fromSexa(
          ' ', 12, 0, 0); // conversion to radians happens here
      expect(a.rad, 3.141592653589793); // no cost to access radians here
    });

    test('ExampleHourAngle_Sec', () {
      final a = HourAngle.fromSexa(' ', 0, 1, 23);
      expect(a.sec, closeTo(83, 0.000001));
    });

    test('ExampleHourAngle_Sin', () {
      final h = HourAngle.fromHour(4);
      expect(h.sin(), closeTo(0.866025, 0.000001));
    });

    test('ExampleHourAngle_Tan', () {
      final h = HourAngle.fromHour(4);
      expect(h.tan(), closeTo(1.732051, 0.000001));
    });

    test('ExampleHourAngle_Time', () {
      final h = HourAngle.fromHour(-2);
      expect(h.hour, -2);
      expect(h.time(), Time.fromHour(-2));
    });
  });

  group('Time tests', () {
    test('ExampleTime', () {
      final t = Time(1.23);
      expect(t.toString(), '1.23');
    });

    test('ExampleFromSexa', () {
      final t = Time.fromSexa('-', 12, 34, 45.6);
      expect(t.toIso8601String(), '-12:34:45.600000');
    });

    test('ExampleTime.fromDay', () {
      final t = Time.fromDay(1);
      expect(t.sec, 86400);
      expect(t, Time.fromHour(24));
    });

    test('ExampleTime.fromHour', () {
      final t = Time.fromHour(-1);
      expect(t.sec, -3600);
      expect(t.hour, -1);
    });

    test('ExampleTime.fromMin', () {
      expect(Time.fromMin(.5), Time(30));
    });

    test('ExampleTime.fromRad', () {
      final t = Time.fromRad(math.pi);
      expect(t.hour, closeTo(12, 0.000001));
    });

    test('ExampleTime_Angle', () {
      final t = Time.fromHour(-2);
      expect(t.hour, -2);
      expect(t.angle(), Angle.fromDeg(30));
    });

    test('ExampleTime_Day', () {
      final t = Time.fromSexa(0, 48, 36, 0);
      expect(t.day, 2.025);
    });

    test('ExampleTime_Div', () {
      final t = Time.fromHour(6);
      expect(t.div(2), Time.fromHour(3));
    });

    test('ExampleTime_Hour', () {
      final t = Time.fromSexa(0, 2, 15, 0);
      expect(t.hour, 2.25);
    });

    test('ExampleTime_HourAngle', () {
      final t = Time.fromHour(-1.5);
      expect(t.hourAngle(), HourAngle.fromSexa('-', 1, 30, 0));
    });

    test('ExampleTime_Min', () {
      final t = Time.fromSexa(0, 0, 1, 30);
      expect(t.min, 1.5);
    });

    test('ExampleTime_Mod1', () {
      final t = Time.fromHour(25);
      expect(t.sec, 90000);
      expect(t.mod1(), Time(3600));
      expect(t.mod1(), Time.fromHour(1));
    });

    test('ExampleTime_Mul', () {
      final t = Time.fromHour(3);
      expect(t.mul(2), Time.fromHour(6));
    });

    test('ExampleTime_Rad', () {
      final t = Time.fromSexa(0, 12, 0, 0);
      expect(t.rad, 3.141592653589793);
    });

    test('ExampleTime_Sec', () {
      final t = Time.fromSexa(0, 0, 1, 30);
      expect(t.sec, 90);
    });
  });
}
