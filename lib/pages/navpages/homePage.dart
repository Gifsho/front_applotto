import 'package:flutter/material.dart';
import 'package:my_project/pages/checkpage/checkLotto.dart';
import 'package:my_project/pages/paypage/searchLotto.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotto'),
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(Icons.account_balance_wallet, color: Colors.black),
                SizedBox(width: 5),
                Text("\$250.41", style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "งวดวันที่ xx/xx/xxxx",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(30),
              child: const Icon(Icons.casino, size: 80),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchLotto()), // ระบุหน้าใหม่
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("ซื้อสลากดิจิทัล"),
              ),

            const SizedBox(height: 20),
            const Divider(),
            const Text(
              "ผลรางวัลสลาก",
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("งวดวันที่ xx/xx/xxxx", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("รางวัลที่ 1", style: TextStyle(fontSize: 16)),
                Text("เลขท้าย 2 ตัว", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("99124", style: TextStyle(fontSize: 18)),
                Text("19", style: TextStyle(fontSize: 18)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckLottoPage()), // นำทางไปยังหน้า checkLotto
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.grey[200], // สีของปุ่ม
                ),
                child: const Text(
                  "ตรวจสลากดิจิทัล",
                  style: TextStyle(color: Colors.black),
                ),
              ),

          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'สลากของฉัน'),
      //     BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'อื่นๆ'),
      //   ],
      //   currentIndex: 0,
      //   onTap: (int index) {
      //     // Add navigation logic here
      //   },
      // ),
    );
  }
}
