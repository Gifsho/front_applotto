import 'package:flutter/material.dart';
import 'package:my_project/pages/paypage/payMoney.dart';

class SearchLotto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ค้นหาเลขเด็ด"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // กลับไปยังหน้าที่แล้ว
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
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
            _buildLottoItem("98123", "80 บาท"),
            _buildLottoItem("99124", "80 บาท"),
            _buildLottoItem("98125", "80 บาท"),
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

          ],
        ),
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

  Widget _buildLottoItem(String number, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          leading: Text(
            "สลากกินแบ่ง\n$number",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: TextButton(
            onPressed: () {
              // กดเพื่อเลือกสลากนี้
            },
            child: const Text("เลือก", style: TextStyle(color: Colors.purple)),
          ),
          subtitle: Text(price),
        ),
      ),
    );
  }
}
