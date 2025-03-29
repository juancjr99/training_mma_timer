String toMinutesStr(int duration) {
  return ((duration / 60) % 60).floor().toString().padLeft(2, '0');
}

String toSecondsStr(int duration) {
  return (duration % 60).floor().toString().padLeft(2, '0');
}