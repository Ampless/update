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
          'https://api.github.com/repos/$repo/releases/latest',
          readCache: false,
          writeCache: false));
      if (Version.parse(currentVersion) < Version.parse(json['tag_name']))
        return UpdateInfo(json['tag_name'], json['html_url']);
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}
