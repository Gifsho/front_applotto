// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:my_project/config/config.dart';
import 'package:my_project/config/configg.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class Page2 extends StatefulWidget {
  const Page2({super.key, required this.token});

  final String token;

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int selectedIndex = 0;
  String? email;
  String? _id;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _decodeToken();
    Configuration.getConfig().then(
      (value) {
        // dev.log(value['apiEndpoint']);
        final url = value['apiEndpoint'];
      },
    );
  }

  Future<void> _decodeToken() async {
    try {
      if (widget.token.isNotEmpty) {
        final Map<String, dynamic> jwtDecodedToken =
            JwtDecoder.decode(widget.token);
        setState(() {
          email = jwtDecodedToken['email'] as String?;
          _id = jwtDecodedToken['_id'] as String?; // แยก
          isLoading = false;
        });

        dev.log('Decoded token: ${jwtDecodedToken.toString()}');
        // dev.log('Email: $email');
        // dev.log('_id: $_id');
      } else {
        setState(() {
          email = 'No token provided';
          _id = null;
          isLoading = false;
        });

        dev.log('No token provided.');
      }
    } catch (e) {
      setState(() {
        email = 'Error decoding token';
        _id = null;
        isLoading = false;
      });
      dev.log('Error decoding token: $e');
    }
  }

  Future<Map<String, dynamic>> _fetchLottos() async {
    await _decodeToken();

    if (_id == null || _id!.isEmpty) {
      throw Exception('User ID is not available');
    }

    try {
      final response = await http.get(Uri.parse('$ticket$_id'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        dev.log('Received data: $data');

        if (data is Map<String, dynamic> && data.containsKey('data')) {
          final ticketData = data['data'];

          if (ticketData is Map<String, dynamic>) {
            return ticketData;
          } else {
            throw Exception('Invalid data format: "data" is not a map');
          }
        } else {
          throw Exception('Invalid data format: no key "data"');
        }
      } else {
        throw Exception(
            'Failed to load lottos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load lottos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'สลากของฉัน',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(color: Colors.black),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'สลาก งวดวันที่ 16 มิ.ย 2558',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),

//--------------------------------------------------------------------------DB//

            FutureBuilder<Map<String, dynamic>>(
              future: _fetchLottos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Log the error for debugging
                  dev.log('Error: ${snapshot.error}');
                  return Center(
                      child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('ไม่พบข้อมูลสลากกินแบ่ง'));
                } else {
                  final ticket = snapshot.data!;
                  // dev.log('data: $ticket');

                  // Ensure 'ticket' key exists and is a String
                  if (ticket.containsKey('ticket') &&
                      ticket['ticket'] is String) {
                    final lottoNumberStr = ticket['ticket'];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white, 
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 7.0,
                            color: Colors.black, 
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                            8),
                      ),
                      margin: const EdgeInsets.all(
                          8), 
                      child: Padding(
                        padding: const EdgeInsets.all(
                            16), 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text('Lotto Number:'),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lottoNumberStr,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(1.7, 1.7),
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(child: Text('ไม่มีข้อมูล'));
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardItem(String title, String number, String price) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(number),
        trailing: Text(price),
      ),
    );
  }
}
