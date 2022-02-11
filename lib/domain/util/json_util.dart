/// Parse the time to store it in the database.
///
/// Used in freezed model classes which require to store [DateTime] data.
/// The date is set to UTC, then convert it into a ISO-8601 full-precision extended format representation
/// using [DateTime.toIso8601String].
dynamic dateTimeToJson(DateTime? dateTime) => dateTime?.toUtc().toIso8601String();

/// Parse the incoming date data from the database.
///
/// Because we know the date should be a [String], from [dateTimeToJson], we try and parse the incoming data
/// and convert it from UTC to local time zone using [DateTime.toLocal].
DateTime? dateTimeFromJson(dynamic dateTimeData) =>
    DateTime.tryParse(dateTimeData.toString())?.toLocal();
