final class CheckLength {

 static void checkLength(String value, String varName, int min, int max) {
    value = value.trim();
    assert(
      value.length >= min && value.length <= max,
      '$varName length is not valid. Expected $min-$max, got ${value.length} ($value)',
    );
  }

}
