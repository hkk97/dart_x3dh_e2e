import 'dart:io';
import 'dart:convert';
import 'package:benchmarking/benchmarking.dart';
import 'package:dart_3xdh_e2e/encryption_ser.dart';
import 'package:dart_3xdh_e2e/models/message.dart';

void main() {
  final messagesJson = File('data/messages.json').readAsStringSync();
  final messages = jsonDecode(messagesJson) as List<dynamic>;
  final encryptionBenchmark = syncBenchmark(
    'DartX3DHE2ESer',
    () async {
      for (final messageStr in messages) {
        final message = Message.fromJson(messageStr);
        final encryptedRes = await DartX3DHE2ESer().encryptWithStringKey(
          message.keyPair.u1SharedSecretKey,
          message.text,
        );
        final decryptedText = await DartX3DHE2ESer().decryptWithStringKey(
          message.keyPair.u2SharedSecretKey,
          encryptedRes[0],
          encryptedRes[1],
          encryptedRes[2],
        );
        if (decryptedText != message.text) {
          break;
        }
        // expect(decryptedText, message.text);
      }
    },
  );
  encryptionBenchmark.report();
}
