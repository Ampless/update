import 'package:schttp/schttp.dart';
import 'package:test/test.dart';
import 'package:update/update.dart';

void main() {
  final get = ScHttpClient().get;
  final amp = 'Ampless/Amplessimus';
  final testCase = (String ver, bool outdated) => () async {
        expect(await UpdateInfo.getFromGitHub(amp, ver, get) != null, outdated);
      };
  test('amp case 1', testCase('1.10.69', true));
  test('amp case 2', testCase('2.1.10', true));
  test('amp case 3', testCase('3.6.20', true));
  test('amp case 4', testCase('69.11.12', false));
}
