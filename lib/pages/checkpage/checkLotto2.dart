import 'package:flutter/material.dart';

class CheckLottoPage2 extends StatefulWidget {
  const CheckLottoPage2({super.key});

  @override
  State<CheckLottoPage2> createState() => _CheckLottoPage2State();
}

class _CheckLottoPage2State extends State<CheckLottoPage2> {
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
      body: Center( // เปลี่ยนจาก Padding เป็น Center เพื่อให้อยู่กึ่งกลาง
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดให้อยู่กึ่งกลาง
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ตัวเลขล็อตโต้
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLottoNumberDisplay('99124'),
                  const SizedBox(width: 20), // เพิ่มช่องว่างระหว่างปุ่ม
                  // ปุ่มขึ้นเงิน
                  ElevatedButton(
                    onPressed: () {
                      // ฟังก์ชันการขึ้นเงิน
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20), // เพิ่มขนาดปุ่ม
                    ),
                    child: const Text(
                      'ขึ้นเงิน',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
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
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0), // ขยายขนาด padding
        child: Text(
          number,
          style: const TextStyle(fontSize: 40, letterSpacing: 10), // เพิ่มขนาดตัวอักษรและระยะห่าง
        ),
      ),
    );
  }
}
