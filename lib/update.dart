import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';

class UpdateInfo {
  final String version, url;

  UpdateInfo(this.version, this.url);

  static Future<UpdateInfo?> getFromGitHub(
    String repo,
    String currentVersion,
    Future<String> Function(String, {bool readCache, bool writeCache}) httpGet,
  ) async {
    try {
      final json = jsonDecode(await httpGet(
          'https://api.github.com/repos/$repo/releases',
          readCache: false,
          writeCache: false));
      for (final release in json)
        if (!release['prerelease'] &&
            Version.parse(currentVersion) < Version.parse(release['tag_name']))
          return UpdateInfo(release['tag_name'], release['html_url']);
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}
