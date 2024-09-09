import 'package:flutter/material.dart';
import 'package:my_project/config/config.dart';
import 'package:my_project/config/configg.dart';
import 'package:my_project/pages/paypage/payMoney.dart';
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;

class SearchLotto extends StatefulWidget {
  const SearchLotto({Key? key}) : super(key: key);

  @override
  _SearchLottoState createState() => _SearchLottoState();
}

class _SearchLottoState extends State<SearchLotto> {
  Future<List<Map<String, dynamic>>> _lottosFuture = Future.value([]);
    String url = '';
  String text = "";

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then(
      (value) {
        dev.log(value['apiEndpoint']);
        url = value['apiEndpoint'];
      },
    );
    _lottosFuture = _fetchLottos();
  }

  Future<List<Map<String, dynamic>>> _fetchLottos() async {
    try {
      final response = await http.get(Uri.parse(lottos));

      if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Received data: $data'); // พิมพ์ข้อมูลที่ได้รับจาก API

      // ตรวจสอบโครงสร้างของข้อมูล
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        final lottoItems = data['data']; // ปรับคีย์ให้ตรงกับข้อมูลที่ได้รับ
        if (lottoItems != null && lottoItems is List) {
          return List<Map<String, dynamic>>.from(lottoItems);
        } else {
          throw Exception('Invalid data format: items is null or not a list');
        }
      } else {
        throw Exception('Invalid data format: no key "items"');
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
        crossAxisAlignment: CrossAxisAlignment.center, // เพิ่มการจัดแนว
        children: [
          const SizedBox(height: 20),
          const Icon(Icons.casino, size: 100),
          const Text(
            "งวด วันที่ 16 มิ.ย. 2558",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNumberBox("9"),
              _buildNumberBox("9"),
              _buildNumberBox("8"),
              _buildNumberBox(""),
              _buildNumberBox(""),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement search logic
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              backgroundColor: Colors.purple[200],
            ),
            child: const Text("ค้นหาเลขเด็ด"),
          ),
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
                  return const Center(child: Text('ไม่พบข้อมูลสลากกินแบ่ง'));
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
                              // TODO: Implement lotto selection logic
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
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PayMoney()), // นำทางไปยังหน้า payMoney
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
  Widget _buildNumberBox(String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}