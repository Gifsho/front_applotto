import 'package:flutter/material.dart';
import 'package:my_project/pages/checkpage/checkLotto2.dart';

class CheckLottoPage extends StatefulWidget {
  const CheckLottoPage({super.key});

  @override
  State<CheckLottoPage> createState() => _CheckLottoPageState();
}

class _CheckLottoPageState extends State<CheckLottoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // สีพื้นหลังเหมือนในภาพ
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าก่อนหน้า
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // ให้คอลัมน์มีขนาดเล็กที่สุดเพื่อให้เนื้อหาอยู่ตรงกลาง
          children: [
            // เพิ่ม title Lotto
            const Text(
              'Lotto',
              style: TextStyle(
                fontSize: 32, // ขนาดใหญ่เพื่อให้ชัดเจน
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            // ตัวเลขล็อตโต้ที่ใหญ่และยาวขึ้น
            _buildLottoNumberDisplay('34219'),
            _buildLottoNumberDisplay('99124'),
            _buildLottoNumberDisplay('34269'),
            const SizedBox(height: 20),
            // ปุ่มตรวจสลาก
            ElevatedButton(
                    onPressed: () {
                      // นำทางไปยังหน้า CheckLottoPage2
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckLottoPage2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      child: Text(
                        'ตรวจสลากดิจิทัล',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),

          ],
        ),
      ),
    );
  }

  Widget _buildLottoNumberDisplay(String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // ขนาดยาวขึ้น 80% ของความกว้างหน้าจอ
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0), // ขนาด padding ใหญ่ขึ้น
          child: Text(
            number,
            textAlign: TextAlign.center, // จัดข้อความให้อยู่ตรงกลาง
            style: const TextStyle(
              fontSize: 32, // ขนาดใหญ่ขึ้น
              letterSpacing: 8, // ช่องว่างระหว่างตัวอักษรเพิ่มขึ้น
            ),
          ),
        ),
      ),
    );
  }
}
