import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "shop-mate-44217",
        "private_key_id": "0750484bb69784f9a396da7f10111d876febc143",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDws7BH2P057WgI\nqxeL2sF03egb174ECngTKI+SsP9/LgZi0xYKSLybPK9ECKF0NQk1wtMMQUHP7T7K\nHiYjMnRKFNbK1BMDL2zBrjKPyYABXxk3DBt/Nvgkgjec8wOYy8omFKVR3cxG+qte\nCbn2TNizCcZE9VhzaaXmBFpZNZnJhEcUtY3Z/IRBSxU2/6hqE+HaRvlTWsluFd2c\nko4iopmL2Ak3Jh8nVno88NjjYuNDamOfVU+SCExh5ox/tRJ+fEPzCX+5SwSIRGYt\n8cn1UVDlMFKtduhOeDkQU9GyB1WPRycXu6Y1VA4ru+IAzYRayKIlaybVEwpPXQlc\nrVXhCy2LAgMBAAECgf8igaAQrL4HD+gm75NW+VIo7to98GMAZH/SP0siotbKsYGf\nQtbMb23NoDJM21ZKBbbMSwgpn/4cHZn8X7x+Tz1clKA2QGQS9zmGiowbd0eVt4xl\n19Z/sxTfwJgFNNFoyWfkp0Q/K3M3IB7XdfPmDoSb8uRf/mXJWQ8inbBWGaXYvYng\najvWQDEUO3MpkPpdRTGN9uw6EgKkFq38PUMTPUdsLWCaK1wEel0orbC5i2tIWBXo\n7EWph1/Fx2q4yuBJMSrnGrpvMu/7sQcTDpJe3Pio268rBiuk6bOlIr86GawPmuos\nItbPGce9Rc00Y11YFeQJJqUpp4Ydi5JOZnOm+RECgYEA+GHt3tx7MGIvCWUT7NRa\nN1e76pKjLQTXQreFKekd5xN6Z17qfGVStRrhfKII4dPGoz3jRhfbGuA98piSLlDd\npiv+wIVQWj2IgFZeBRdsQ2XBA13Soh7DpSfVZfQfqHcq2fKGk1PRsJ3JyFO5kskM\nlrjAlU2dMkv/QjbbgEXbQ3ECgYEA+BV1TPi7Bjxp+FONSEaQzelf98s6faPYnpCE\nV5FmUyvw0Lk3BTQmxvfpWXE9GakYdsMK7Ps3ZzVBcAtX603tw3s0Yiig4NNAW0SA\nnOo0+oFSZ4rf/o9ipPFM81OMTczvIVtC8cgesPsXe323YljiKqp0/Y29yOC0XXWJ\nlRDmirsCgYB7RLa17PxiRcgMRJK/7Z+cablEMGQ1OnrOjJ/U7fG+NaeA19VNyUdj\nxCR2I0B/OwgRCezaY4qE6xczZ87cl5t5FcqHp2H6dyFgd/yPUFGVnVFOJ2katmPo\nej1pLN/tTr8AjWGGiom9uoFjH1Iw7ACIaMaDEpLaXGchaHJFVeX8sQKBgQCl95UV\n/YEBVwF+BEeMhsjxOKPfXrKuwyJ0UjJ3cuqF0eu1d3N7o7wdeFVAZSV/OUUIjsuM\nZzRVc6dnke8rmGLsWExfLtcSEcIITPfOAlGXFVVPt/TKlJplxpi4YLiIhAWmxysu\nHbeKpzC6iQxaWyRTbt39kwnYjZucurlkZH4XaQKBgQDZdaQoO5BSl2cJkkJqQ4Ev\nguUpLK9WWLoMPqp3lFVEjIlr52b41P16hC77LcFjBha6VUF1c7/jh0ur4OTfFLYp\nw/5ElfIdPNX3uFRl0yEh/EnGUoy3pFfcx5KhVeMl4A3RksN8TOTmJpM+24tEZvV6\nosKv2o7tlM4WLmy4Uaaa9g==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-axcgx@shop-mate-44217.iam.gserviceaccount.com",
        "client_id": "107113377633569530323",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-axcgx%40shop-mate-44217.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
