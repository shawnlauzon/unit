// License: MIT

import 'dart:math' as math;

/// Converts from parsed sexagesimal angle components to a single
/// num value.
///
/// The result is in the units of [d], the first or "largest" sexagesimal
/// component.
///
/// Typically you pass non-negative values for [d], [m], and [s], and to indicate
/// a negative value, pass '-' for [neg].  Any other value, such as ' ', '+',
/// or simply 0, leaves the result non-negative.
///
/// There are no limits on [d], [m], or [s] however.  Negative values or values
/// > 60 for m and s are allowed for example.  The segment values are
/// combined and then if neg is '-' that sum is negated.
///
/// This function would commonly be called something like DMSToDegrees, but
/// the interpretation of d as degrees is arbitrary.  The function works
/// as well on hours minutes and seconds.  Regardless of the units of [d],
/// [m] is a sexagesimal part of [d] and [s] is a sexagesimal part of [m].
num fromSexa(dynamic neg, int d, int m, num s) {
  return fromSexaSec(neg, d, m, s) / 3600;
}

/// Converts from parsed sexagesimal angle components to a single
/// num value.
///
/// The result is in the units of [s], the last or "smallest" sexagesimal
/// component.
///
/// Otherwise fromSexaSec works as [fromSexa()].
num fromSexaSec(dynamic neg, int d, int m, num s) {
  s = ((d * 60 + m) * 60) + s;
  return neg == '-' ? -s : s;
}

/// A general purpose angle.
///
/// The value is stored as radians.
///
/// There is no "AngleFromRad" constructor.  If you have a value [rad] in
/// radians, construct a corresponding Angle simply with the constructor
/// [Angle(rad)].
class Angle {
  /// The angle in radians.
  ///
  /// This is the underlying representation and involves no scaling.
  final num rad;

  /// ---------- Angle constructors: ----------

  /// Constructs an Angle value from radians.
  const Angle(this.rad);

  /// Constructs an Angle value from a value representing angular
  /// degrees where there are 360 degrees to a circle or revolution.
  ///
  /// This provides "Deg2Rad" functionality but hopefully in a more clear way.
  const Angle.fromDeg(num d) : this(d / 180 * math.pi);
  // 180 deg or pi radians in a half-circle.

  /// Constructs an Angle value from a value representing angular
  /// minutes where there are 60 minutes to a degree, and 360 degrees to a circle.
  const Angle.fromMin(num m) : this(m / 60 / 180 * math.pi);
  // 60 min in a degree, 180 deg or pi radians in a half-circle.

  /// Constructs an Angle value from a value representing angular
  /// seconds where there are 60 seconds to a minute, 60 minutes to a degree,
  /// and 360 degrees to a circle.
  const Angle.fromSec(num s) : this(s / 3600 / 180 * math.pi);
  // 3600 sec in a degree, 180 deg or pi radians in a half-circle.

  /// Constructs a new Angle value from sign, degree, minute, and second
  /// components.
  ///
  /// For [neg], pass '-' to negate the result.  Any other argument
  /// value, such as ' ', '+', or simply 0, leaves the result non-negated.
  //
  // This was the NewAngle function in the original Go code.
  Angle.fromSexa(dynamic neg, int d, int m, num s)
      : this.fromSec(fromSexaSec(neg, d, m, s));

  // ---------- Angle "getters" or conversions: ----------

  /// The angle in degrees.
  ///
  /// This provides a "Rad2Deg" functionality but hopefully in a more clear way.
  num get deg => rad * 180 / math.pi;

  /// The angle in minutes.
  num get min => rad * 60 * 180 / math.pi;

  /// The angle in seconds.
  num get sec => rad * 3600 * 180 / math.pi;

  /// Constructs an HourAngle value corresponding to this angle.
  ///
  /// As both types represent angles in radians, this is a zero-cost conversion.
  HourAngle hourAngle() => HourAngle(rad);

  /// Constructs a Time value where one circle of Angle corresponds to
  /// one day of Time.
  Time time() => Time.fromRad(rad);

  // ---------- Angle math: ----------

  /// Returns the scalar product angle*f
  Angle mul(num f) => Angle(rad * f);

  /// Returns the scalar quotient angle/d
  Angle div(num d) => Angle(rad / d);

  /// Returns Angle a wrapped to 1 circle.
  Angle mod1() => Angle(rad % (2 * math.pi));

  /// Returns the trigonometric sine of this angle.
  num sin() => math.sin(rad);

  /// Returns the trigonometric cosine of this angle.
  num cos() => math.cos(rad);

  /// Returns the trigonometric tangent of this angle.
  num tan() => math.tan(rad);

  /// Returns the absolute value of this angle.
  Angle abs() => Angle(rad.abs());

  // ---------- Simple number math: ----------

  Angle operator +(Angle other) => Angle(rad + other.rad);
  Angle operator -(Angle other) => Angle(rad - other.rad);
  Angle operator *(num scalar) => Angle(rad * scalar);
  Angle operator /(num scalar) => Angle(rad / scalar);

  bool operator <(Angle other) => rad < other.rad;
  bool operator <=(Angle other) => rad <= other.rad;
  bool operator >(Angle other) => rad > other.rad;
  bool operator >=(Angle other) => rad >= other.rad;

  // ---------- Standard overrides: ----------

  @override
  bool operator ==(other) => other is Angle && rad >= other.rad;

  @override
  int get hashCode => rad.hashCode;

  @override
  String toString() => rad.toString();
}

/// An angle corresponding to angular rotation of the Earth.
///
/// The value is stored as radians.
class HourAngle {
  /// The hour angle as an angle in radians.
  ///
  /// This is the underlying representation and involves no scaling.
  final num rad;

  const HourAngle(this.rad);

  /// Constructs an HourAngle value from a value representing
  /// hours of rotation or revolution where there are 24 hours to a revolution.
  const HourAngle.fromHour(num h) : this(h / 12 * math.pi);
  // 12 hours or pi radians in a half-revolution

  /// Constructs an HourAngle value from a value representing
  /// minutes of revolution where there are 60 minutes to an hour and 24 hours
  /// to a revolution.
  const HourAngle.fromMin(num m) : this(m / 60 / 12 * math.pi);
  // 60 sec in an hour, 12 hours or pi radians in a half-revolution

  /// Constructs an HourAngle value from a value representing
  /// seconds of revolution where there are 60 seconds to a minute, 60 minutes
  /// to an hour, and 24 hours to a revolution.
  const HourAngle.fromSec(num s) : this(s / 3600 / 12 * math.pi);
  // 3600 sec in an hour, 12 hours or pi radians in a half-revolution

  /// Constructs a new Angle value from sign, degree, minute, and second
  /// components.
  ///
  /// For argument [neg], pass '-' to negate the result.  Any other argument
  /// value, such as ' ', '+', or simply 0, leaves the result non-negated.
  //
  // This was the NewHourAngle function in the original Go code.
  HourAngle.fromSexa(dynamic neg, int h, int m, num s)
      : this(fromSexa(neg, h, m, s) / 12 * math.pi);

  // ---------- HourAngle "getters" or conversions: ----------

  /// The hour angle as hours of revolution.
  num get hour => rad * 12 / math.pi;

  /// The hour angle as minutes of revolution.
  num get min => rad * 60 * 12 / math.pi;

  /// The hour angle as seconds of revolution.
  num get sec => rad * 3600 * 12 / math.pi;

  /// Returns an Angle value where one revolution or 24 hours of HourAngle
  /// corresponds to one circle of Angle.
  Angle angle() => Angle(rad);

  /// Returns a Time value where one revolution or 24 hours or HourAngle
  /// corresponds to one day of Time.
  Time time() => Time(sec);

  // ---------- Hour angle math: ----------

  /// Returns the scalar product angle*f
  HourAngle mul(num f) => HourAngle(rad * f);

  /// Returns the scalar quotient angle/d
  HourAngle div(num f) => HourAngle(rad / f);

  /// Returns the trigonometric sine of this angle.
  num sin() => math.sin(rad);

  /// Returns the trigonometric cosine of this angle.
  num cos() => math.cos(rad);

  /// Returns the trigonometric tangent of this angle.
  num tan() => math.tan(rad);

  /// Returns the absolute value of this angle.
  HourAngle abs() => HourAngle(rad.abs());

  // ---------- Simple number math: ----------

  HourAngle operator +(Angle other) => HourAngle(rad + other.rad);
  HourAngle operator -(Angle other) => HourAngle(rad - other.rad);
  HourAngle operator *(num scalar) => HourAngle(rad * scalar);
  HourAngle operator /(num scalar) => HourAngle(rad / scalar);

  bool operator <(HourAngle other) => rad < other.rad;
  bool operator <=(HourAngle other) => rad <= other.rad;
  bool operator >(HourAngle other) => rad > other.rad;
  bool operator >=(HourAngle other) => rad >= other.rad;

  // ---------- Standard overrides: ----------

  @override
  bool operator ==(other) => other is HourAngle && rad >= other.rad;

  @override
  int get hashCode => rad.hashCode;

  @override
  String toString() => rad.toString();
}

/// A duration or relative time.
///
/// The value is stored as seconds.
class Time {
  /// The time in seconds.
  ///
  /// This is the underlying representation and involves no scaling.
  final num sec;

  // ---------- Time constructors: ----------

  /// Create a new time given number of seconds
  const Time(num seconds) : sec = seconds;

  /// Constructs a new Time value from sign, hour, minute, and
  /// second components.
  ///
  /// For argument [neg], pass '-' to negate the result.  Any other argument
  /// value, such as ' ', '+', or simply 0, leaves the result non-negated.
  //

  const Time.fromSexa(dynamic neg, int h, int m, num s)
      : this((s + (h * 60 + m) * 60) * (neg == '-' ? -1 : 1));

  /// Constructs a Time value from a value representing days.
  const Time.fromDay(num d)
      : this(d * 3600 * 24); // 3600 sec in an hour, 24 hours in a day

  /// Constructs a Time value from a value representing hours
  /// of time.
  const Time.fromHour(num h) : this(h * 3600); // 3600 sec in an hour

  /// Constructs a Time value from a value representing minutes
  /// of time.
  const Time.fromMin(num m) : this(m * 60); // 60 sec in a min

  /// Constructs a Time value from radians where 2 pi radians
  /// corresponds to one day.
  const Time.fromRad(num rad) : this(rad * 3600 * 12 / math.pi);
  // 3600 sec in an hour, 12 hours or pi radians in a half-day

  // ---------- Time "getters" or conversions: ----------

  /// Time in days.
  num get day => sec / 3600 / 24;

  /// Time in hours.
  num get hour => sec / 3600;

  /// Time in minutes.
  num get min => sec / 60;

  /// Returns time in radians, where 1 day = 2 Pi radians of rotation.
  num get rad => sec / 3600 / 12 * math.pi;

  /// Returns time t as an equivalent angle where 1 day = 2 Pi radians.
  Angle angle() => Angle(rad);

  // HourAngle returns time t as an equivalent hour angle where
  // 1 day = 2 Pi radians or 24 hours of HourAngle.
  HourAngle hourAngle() => HourAngle(rad);

  // ---------- Time math: ----------

  /// Returns the scalar product time*f
  Time mul(num f) => Time(sec * f);

  /// Returns the scalar quotient time/d
  Time div(num d) => Time(sec / d);

  /// Returns a new Time wrapped to one day, the range [0,86400) seconds.
  Time mod1() => Time(sec % (3600 * 24));

  // ---------- Simple number math: ----------

  Time operator +(Time other) => Time(sec + other.sec);
  Time operator -(Time other) => Time(sec - other.sec);

  Time operator *(num scalar) => Time(sec * scalar);
  Time operator /(num scalar) => Time(sec / scalar);

  bool operator <(Time other) => sec < other.sec;
  bool operator <=(Time other) => sec <= other.sec;
  bool operator >(Time other) => sec > other.sec;
  bool operator >=(Time other) => sec >= other.sec;

  /// Returns the time formatted as an ISO8601 string.
  String toIso8601String() {
    final secs = sec.truncate();
    final millisFrac = ((sec - secs) * 1000);
    final millis = millisFrac.truncate();
    final micros = ((millisFrac - millis) * 1000).round();
    return Duration(seconds: secs, milliseconds: millis, microseconds: micros)
        .toString();
  }

  // ---------- Standard overrides: ----------

  @override
  bool operator ==(other) => other is Time && sec == other.sec;

  @override
  int get hashCode => sec.hashCode;

  @override
  String toString() => sec.toString();
}
