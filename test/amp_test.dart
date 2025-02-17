import 'package:schttp/schttp.dart';
import 'package:tested/tested.dart';
import 'package:update/update.dart';

void main() {
  final testCase = (ver, outdated) => expectTestCase(
      () async =>
          await UpdateInfo.getFromGitHub(
              'Ampless/Amplessimus', ver, ScHttpClient().get) !=
          null,
      outdated);

  tests([
    testCase('1.10.69', true),
    testCase('2.1.10', true),
    testCase('3.6.20', true),
    testCase('69.11.12', false),
  ], 'amplessimus');
}
