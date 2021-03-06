library test.jaguar.response.stream;

import 'package:http/io_client.dart' as http;
import 'dart:async';
import 'package:jaguar_resty/jaguar_resty.dart' as resty;
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:jaguar/jaguar.dart';
import '../../ports.dart' as ports;

void main() {
  resty.globalClient = new http.IOClient();

  group('route', () {
    final port = ports.random;
    Jaguar server;
    setUpAll(() async {
      print('Using port $port');
      server = new Jaguar(port: port);
      server
        ..get('/stream', (Context ctx) {
          StreamController<List<int>> streamCon =
              new StreamController<List<int>>();

          new Timer(new Duration(seconds: 5), () {
            streamCon.add([1, 2, 3, 4]);
            streamCon.add([5, 6, 7, 8]);
            streamCon.close();
          });

          return streamCon.stream;
        });
      await server.serve();
    });

    tearDownAll(() async {
      await server.close();
    });

    test(
        'stream',
        () => resty.get('http://localhost:$port/stream').exact(
            statusCode: 200,
            bytes: [1, 2, 3, 4, 5, 6, 7, 8],
            mimeType: 'text/plain'));
  });
}
