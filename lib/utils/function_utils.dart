bool isNullOrEmpty(dynamic value) {
  if (value == null) {
    return true;
  }

  if (value is String) {
    if (value.trim().isEmpty || value == 'null') {
      return true;
    }
  }

  return false;
}