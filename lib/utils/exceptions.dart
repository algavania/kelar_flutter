class InvalidFileException implements Exception {}

class DurationTooSmallException implements Exception {
  DurationTooSmallException({required this.duration});

  final Duration duration;
}
