import 'package:test/test.dart';
import 'package:dart_3xdh_e2e/encryption_ser.dart';

void main() {
  test('hexStringToBytes', () {
    final hexSharedSecretKey =
        '350ff7adbe9e77f14c3d0e3418bbbbda565c367d5915f0698a95ecced1bc0748';
    final bytesSharedSecretKey = [
      53,
      15,
      247,
      173,
      190,
      158,
      119,
      241,
      76,
      61,
      14,
      52,
      24,
      187,
      187,
      218,
      86,
      92,
      54,
      125,
      89,
      21,
      240,
      105,
      138,
      149,
      236,
      206,
      209,
      188,
      7,
      72
    ];
    final ser = DartX3DHE2ESer();
    final res = ser.hexStringToBytes(hexSharedSecretKey);
    expect(res, bytesSharedSecretKey);
  });

  test('encryptDecryptWithBytesKey', () async {
    final u1SharedSecretKey = [
      139,
      36,
      97,
      126,
      75,
      155,
      72,
      221,
      93,
      241,
      50,
      58,
      53,
      57,
      233,
      245,
      233,
      0,
      234,
      90,
      194,
      214,
      10,
      156,
      78,
      92,
      216,
      237,
      118,
      130,
      201,
      92
    ];
    final u2SharedSecretKey = [
      139,
      36,
      97,
      126,
      75,
      155,
      72,
      221,
      93,
      241,
      50,
      58,
      53,
      57,
      233,
      245,
      233,
      0,
      234,
      90,
      194,
      214,
      10,
      156,
      78,
      92,
      216,
      237,
      118,
      130,
      201,
      92
    ];
    final plainText = 'Hello world!';
    final ser = DartX3DHE2ESer();
    final result = await ser.encryptWithBytesKey(u1SharedSecretKey, plainText);
    final decryptedText = await ser.decryptWithBytesKey(
      u2SharedSecretKey,
      result[0],
      result[1],
      result[2],
    );
    expect(decryptedText, plainText);
  });

  test('encryptDecryptWithStringKey', () async {
    final hexSharedSecretKey =
        '350ff7adbe9e77f14c3d0e3418bbbbda565c367d5915f0698a95ecced1bc0748';
    final bytesSharedSecretKey =
        '350ff7adbe9e77f14c3d0e3418bbbbda565c367d5915f0698a95ecced1bc0748';
    final plainText = 'Hello world!';
    final ser = DartX3DHE2ESer();
    final result =
        await ser.encryptWithStringKey(hexSharedSecretKey, plainText);
    final decryptedText = await ser.decryptWithStringKey(
      bytesSharedSecretKey,
      result[0],
      result[1],
      result[2],
    );
    expect(decryptedText, plainText);
  });
}
