import 'package:flutter/material.dart';

class Admin2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลสลากลอตเตอรี่'),
        centerTitle: true,  
        automaticallyImplyLeading: false,  
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '16 มิ.ย. 2558',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            // Prize 1 section
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                children: [
                  Text(
                    'รางวัลที่ 1',
                    style: TextStyle(fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '99812',
                    style: TextStyle(fontSize: 40, color: Colors.red),
                  ),
                  Text(
                    '10,000 บาท',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Other prize sections
            Expanded(
              child: ListView(
                children: [
                  LotteryResultItem(prize: 'รางวัลที่ 2', number: '83487', amount: '8000 บาท'),
                  LotteryResultItem(prize: 'รางวัลที่ 3', number: '43234', amount: '5000 บาท'),
                  LotteryResultItem(prize: 'รางวัลที่ 4', number: '56748', amount: '3000 บาท'),
                  LotteryResultItem(prize: 'รางวัลที่ 5', number: '78914', amount: '1000 บาท'),
                ],
              ),
            ),
            // Button for randomizing new numbers
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('สุ่มรางวัล'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation bar as in the original design
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class LotteryResultItem extends StatelessWidget {
  final String prize;
  final String number;
  final String amount;

  LotteryResultItem({required this.prize, required this.number, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(prize, style: TextStyle(fontSize: 16)),
          Text(number, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(amount, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Reusing BottomNavBar from the previous code for consistency
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'หน้าหลัก',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.confirmation_number),
          label: 'สุ่มสลาก',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'ออกระบบ',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.grey[300],
    );
  }
}
