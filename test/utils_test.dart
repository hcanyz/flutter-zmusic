import 'package:flutter_test/flutter_test.dart';
import 'package:zmusic/common/utils.dart';

void main() {
  test("test_convergenceAmountUnit", () {
    expect(convergenceAmountUnit(2330), "2330");
    expect(convergenceAmountUnit(233000), "24万");
    expect(convergenceAmountUnit(239000), "24万");
  });
}
