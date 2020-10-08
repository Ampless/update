import 'package:schttp/schttp.dart';
import 'package:test/test.dart';

import '../lib/update.dart';

main() {
  final http = ScHttpClient();
  final amp = 'Ampless/Amplessimus';
  final testCase = (String version, bool hasNewVersion) => () async {
        final update = await UpdateInfo.getFromGitHub(amp, version, http.get);
        if (hasNewVersion)
          assert(update != null);
        else
          assert(update == null);
      };
  test('amp case 1', testCase('1.10.69', true));
  test('amp case 2', testCase('2.1.0.4fdecab', true));
  test('amp case 3', testCase('2.1.10', true));
  test('amp case 4', testCase('69.11.12', false));
}
