# Unit

Three types: Angle, HourAngle, and Time, useful in astronomy applications.

This is a Dart port of the original Go library created by Sonia Keys and hosted at
https://github.com/soniakeys/unit. 

These types are all angle-like types.  The Time type is at least angle-related.
It has conversions to and from the other types and has a function to wrap a
Time value to the fractional part of a day.

## Motivation

This package supports https://github.com/shawnlauzon/meeus, which implements a large colection of
astronomy algorithms.

## Install

See installation instructions on [pub.dev](https://pub.dev/packages/unit#-installing-tab-)

## License

MIT