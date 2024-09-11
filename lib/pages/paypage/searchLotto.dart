// ignore_for_file: library_private_types_in_public_api

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter/material.dart';
import 'package:my_project/config/config.dart';
import 'package:my_project/config/configg.dart';
import 'package:my_project/pages/paypage/payMoney.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class SearchLotto extends StatefulWidget {
  const SearchLotto({super.key, required this.token});

  final String token;

  @override
  _SearchLottoState createState() => _SearchLottoState();
}

class _SearchLottoState extends State<SearchLotto> {
  Future<List<Map<String, dynamic>>> _lottosFuture = Future.value([]);
  String url = '';
  String text = "";
  String? email;
  String? _id;
  String nameU = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _decodeToken();
    Configuration.getConfig().then(
      (value) {
        dev.log(value['apiEndpoint']);
        url = value['apiEndpoint'];
      },
    );
    _lottosFuture = _fetchLottos();
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

  Future<List<Map<String, dynamic>>> _fetchLottos([String? lottoNumber]) async {
  try {
    final Uri uri = lottoNumber != null && lottoNumber.isNotEmpty
        ? Uri.parse('$lottoSearch$lottoNumber')
        : Uri.parse('$lottos');
    
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('data')) {
        final lottoItems = data['data'];
        if (lottoItems != null) {
          if (lottoItems is List) {
            return List<Map<String, dynamic>>.from(lottoItems);
          } else if (lottoItems is Map<String, dynamic>) {
            // ในกรณีที่ค้นหาเลขเฉพาะ อาจได้ข้อมูลเพียงรายการเดียว
            return [lottoItems];
          }
        }
        throw Exception('Invalid data format: items is null or not in expected format');
      } else {
        throw Exception('Invalid data format: no key "data"');
      }
    } else {
      throw Exception('Failed to load lottos');
    }
  } catch (e) {
    throw Exception('Failed to load lottos: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการสลากกินแบ่ง'),
      ),
      body: Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    const SizedBox(height: 20),
    const Icon(Icons.casino, size: 100),
    const Text(
      "งวด วันที่ 16 มิ.ย. 2558",
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    const SizedBox(height: 20),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     _buildNumberBox("9"),
    //     _buildNumberBox("9"),
    //     _buildNumberBox("8"),
    //     _buildNumberBox(""),
    //     _buildNumberBox(""),
    //   ],
    // ),
    const SizedBox(height: 20),
    LottoNumberInput(
      onChanged: (value) {
        setState(() {
          text = value;
        });
      },
    ),
    const SizedBox(height: 20),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            if (text.isNotEmpty) {
              setState(() {
                _lottosFuture = _fetchLottos(text);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('กรุณาใส่เลขที่ต้องการค้นหา')),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: Colors.purple[200],
          ),
          child: const Text("ค้นหาเลขเด็ด"),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              text = "";
              _lottosFuture = _fetchLottos();
            });
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            backgroundColor: Colors.blue[200],
          ),
          child: const Text("แสดงทั้งหมด"),
        ),
      ],
    ),

//---------------------------------------------

    const SizedBox(height: 20),
    Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _lottosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('ไม่พบข้อมูล'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final lotto = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(
                      'เลขสลาก: ${lotto['LottoNumber']}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('ราคา: ${lotto['Price']} บาท'),
                    trailing: ElevatedButton(
                      child: const Text('เลือก'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('เลือกสลากเลข ${lotto['LottoNumber']}')),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ),

//--------------------------------

    const SizedBox(height: 20),
    ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PayMoney()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: Colors.purple[200],
      ),
      child: const Text("ชำระเงิน"),
    ),
    const SizedBox(height: 20),
  ],
),
    );
  }
  // Widget _buildNumberBox(String number) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 4),
  //     child: Container(
  //       width: 40,
  //       height: 40,
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.black),
  //         borderRadius: BorderRadius.circular(8),
  //         color: Colors.white,
  //       ),
  //       child: Center(
  //         child: Text(
  //           number,
  //           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class LottoNumberInput extends StatefulWidget {
  final Function(String) onChanged;

  const LottoNumberInput({Key? key, required this.onChanged}) : super(key: key);

  @override
  _LottoNumberInputState createState() => _LottoNumberInputState();
}

class _LottoNumberInputState extends State<LottoNumberInput> {
  List<String> numbers = ['', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(6, (index) => _buildNumberBox(index)),
    );
  }

  Widget _buildNumberBox(int index) {
    return Container(
      width: 40,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            numbers[index] = value;
            widget.onChanged(numbers.join());
          });
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}