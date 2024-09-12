// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_project/pages/checkpage/checkLotto2.dart';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:my_project/config/config.dart';
import 'package:my_project/config/configg.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class CheckLottoPage2 extends StatefulWidget {
  const CheckLottoPage2({super.key, required this.token});

  final String token;

  @override
  State<CheckLottoPage2> createState() => _CheckLottoPage2State();
}

class _CheckLottoPage2State extends State<CheckLottoPage2> {
  String? email;
  String? _id;
  String? nameU;
  String? myToken;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _decodeToken();
    Configuration.getConfig().then(
      (value) {
        dev.log(value['apiEndpoint']);
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
        // dev.log('Response data: $nameU');
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
      final today =
          DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD format

      final url = Uri.parse('http://10.210.60.215:8081/check-prize');

      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({"userId": _id, "drawDate": today}));

      // dev.log('Response status: ${response.statusCode}');
      // dev.log('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);
        if (dataList.isNotEmpty && dataList[0] is Map<String, dynamic>) {
          return dataList[0]; // Return the first item in the array
        } else {
          throw Exception(
              'Invalid data format: response is empty or first item is not a map');
        }
      } else {
        throw Exception(
            'Failed to load lottos. Status code: ${response.statusCode}');
      }
    } catch (e) {
      dev.log('Error in _fetchLottos: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _fetchWallet() async {
    await _decodeToken();

    if (_id == null || _id!.isEmpty) {
      throw Exception('User ID is not available');
    }

    try {
      final response = await http.get(Uri.parse('$addwallet$_id'));

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
          },
        ),
        title: const Text(
          'Lotto',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Center(
        // เปลี่ยนจาก Padding เป็น Center เพื่อให้อยู่กึ่งกลาง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่กึ่งกลาง
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ตัวเลขล็อตโต้
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _buildLottoNumberDisplay('99124'),
              //     const SizedBox(width: 20), // เพิ่มช่องว่างระหว่างปุ่ม
              //     // ปุ่มขึ้นเงิน
              //     ElevatedButton(
              //       onPressed: () {
              //         // ฟังก์ชันการขึ้นเงิน
              //       },
              //       style: ElevatedButton.styleFrom(
              //         backgroundColor: Colors.white,
              //         shape: const CircleBorder(),
              //         padding: const EdgeInsets.all(20), // เพิ่มขนาดปุ่ม
              //       ),
              //       child: const Text(
              //         'ขึ้นเงิน',
              //         style: TextStyle(color: Colors.black, fontSize: 16),
              //       ),
              //     ),
              //   ],
              // ),

              FutureBuilder<Map<String, dynamic>>(
                future: _fetchLottos(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    dev.log('Error in FutureBuilder: ${snapshot.error}');
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('เกิดข้อผิดพลาด: ${snapshot.error}'),
                          ElevatedButton(
                            onPressed: () => setState(() {}),
                            child: Text('ลองใหม่'),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('ไม่พบข้อมูลสลากกินแบ่ง'));
                  } else {
                    final lotto = snapshot.data!;
                    dev.log('data: $lotto');

                    return Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${lotto['prize']} บาท',
                            textAlign: TextAlign.start, // Changed from TextAlign.end for alignment consistency
                            style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildLottoNumberDisplay('${lotto['lottoNumber']}'),
                              ElevatedButton(
                                onPressed: () {
                                  // ฟังก์ชันการตรวจสลากดิจิทัล
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20.0), 
                                  minimumSize: const Size(60, 60),
                                ),
                                  child: const Text('ขึ้นเงิน',style: TextStyle(fontSize: 20), // เพิ่มขนาดตัวอักษรและระยะห่าง
                                ),
                              ), // Simplified to Text widget
                            ],
                          ),
                        ],
                      ),
                    );

                  }
                },
              ),
              const SizedBox(height: 50),
              // ข้อความแสดงผลการถูกรางวัล
              const Text(
                '99124',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'ยินดีด้วยคุณถูกรางวัลที่ 1\nเป็นจำนวนเงิน 10000 บาท',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 50),
              // ปุ่มตรวจสลากดิจิทัล
              ElevatedButton(
                onPressed: () {
                  // ฟังก์ชันการตรวจสลากดิจิทัล
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0), // ขยายปุ่ม
                ),
                child: const Text(
                  'ตรวจสลากดิจิทัล',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLottoNumberDisplay(String number) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40), // ขยายขอบโค้งมน
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 25.0), // ขยายขนาด padding
        child: Text(
          number,
          style: const TextStyle(
              fontSize: 30, letterSpacing: 18), // เพิ่มขนาดตัวอักษรและระยะห่าง
        ),
      ),
    );
  }

  Widget _buildLotto(String number) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40), // ขยายขอบโค้งมน
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15.0, vertical: 27.0), // ขยายขนาด padding
        child: Text(
          number,
          style: const TextStyle(
              fontSize: 20), // เพิ่มขนาดตัวอักษรและระยะห่าง
        ),
      ),
    );
  }
}
