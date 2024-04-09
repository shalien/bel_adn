import 'dart:io';

import 'package:bel_adn/bel_adn.dart';
import 'package:test/test.dart';

void main() async {
  late MagnifiqueCoupleClient client;

  setUpAll(() async {
    client = MagnifiqueCoupleClient(
      host: 'http://localhost:8000',
      accessToken: await File('.env').readAsString(),
    );
  });

  group('Source CRUD', () {});

  tearDownAll(() async {});
}
