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

### 1. Depend on it

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  unit: ^1.0.1
```

### 2. Install it

Install the package from the command line:

```
$ pub get
```

### 3. Import it

Add to your dart code:

```dart
import 'package:unit/unit.dart'
```

## License

MIT