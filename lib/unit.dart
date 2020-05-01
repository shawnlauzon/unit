/// Unit defines some types used in astronomy, and heavily used by the packages
/// in https://github.com/shawnlauzon/meeus.
///
/// This is a Dart port of the excellent set of libraries creatd by Sonia Keys,
/// the most significant of which is https://github.com/soniakeys/meeus. This
/// library was ported in order to support the port of that library. The
/// original unit library is hosted at https://github.com/soniakeys/unit.
///
/// Most of the original Go code has been changed as little as possible, only
/// to make it match Dart semantics. Functions which are capitalized in Go are
/// made into camel case, getter functions converted to getters, and const
/// parameters are used throughout.
///
/// Three types are currently defined: Angle, HourAngle, and Time.  All are
/// commonly formatted in sexagesimal notation and the external Go package
/// https://github.com/soniakeys/sexagesimal has formatting
/// routines. However, this package has not been ported to Dart because it
/// is not required in https://github.com/shawnlauzon/meeus other than for
/// test cases. It also contains mostly Go-specific libraries and so a port to
/// Dart would be non-trivial.
///
/// The Go version of this library includes an additional type: RA. Because
/// the Dart meeus library has not yet implemented functions which require RA,
/// that type has not yet been ported.
///
/// The original types were defined as typedefs, and since these do not exist
/// in Dart, are now defined as classes with the original typedef (in all cases
/// this is num) inside the class. For Angle and HourAngle, the value is always
/// in radians.  For Time, it is seconds.
///
/// The choice of methods defined is somewhat arbitrary.  Methods were defined
/// as they were found convenient for the Meeus library, and then filled out
/// somewhat for consistency.  The convenience is often syntactic; as the
/// underlying type is num conversions to and from num are often free
/// and otherwise typically only incur a multiplication.
library unit;

export 'src/unit_base.dart';
