import 'dart:convert';

import 'package:pub_semver/pub_semver.dart';

class UpdateInfo {
  final String version, url;

  UpdateInfo(this.version, this.url);

  static Future<UpdateInfo?> getFromGitHub(
    String repo,
    String currentVersion,
    Future<String> Function(String) httpGet,
  ) async {
    try {
      final json =
          await httpGet('https://api.github.com/repos/$repo/releases/latest')
              .then(jsonDecode);
      if (Version.parse(currentVersion) < Version.parse(json['tag_name']))
        return UpdateInfo(json['tag_name'], json['html_url']);
      // ignore: empty_catches
    } catch (e) {}
    return null;
  }
}
