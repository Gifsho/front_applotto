import 'package:flutter/material.dart';

class admin1 extends StatefulWidget {
  @override
  _admin1State createState() => _admin1State();
}

class _admin1State extends State<admin1> {
  // Variable to track selected index
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to Admin2 when "สุ่มสลาก" is selected
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Admin2()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แอดมิน"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ToggleButtonsWidget(
              selectedIndex: _selectedIndex,
              onSelect: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            SizedBox(height: 10),
            LotteryDateInfo(),
            SizedBox(height: 10),
            LotteryItem(number: '998123', price: '80 บาท'),
            LotteryItem(number: '998124', price: '80 บาท'),
            LotteryItem(number: '998125', price: '80 บาท'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('รีเซ็ทระบบ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[200],
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}

class ToggleButtonsWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  ToggleButtonsWidget({required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => onSelect(0),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex == 0 ? Colors.purple[200] : Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
          child: Text(
            "ทั้งหมด",
            style: TextStyle(
              fontSize: 16,
              color: selectedIndex == 0 ? Colors.white : Colors.black,
            ),
          ),
        ),
        SizedBox(width: 5),
        ElevatedButton(
          onPressed: () => onSelect(1),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedIndex == 1 ? Colors.purple[200] : Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
          child: Text(
            "ขายแล้ว",
            style: TextStyle(
              fontSize: 16,
              color: selectedIndex == 1 ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

class LotteryDateInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("สลาก งวดวันที่"),
          Text("16 มิ.ย. 2558"),
        ],
      ),
    );
  }
}

class LotteryItem extends StatelessWidget {
  final String number;
  final String price;

  LotteryItem({required this.number, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("สลากกินเเบ่ง\n$number"),
          Text("$price", style: TextStyle(fontSize: 18)),
          ElevatedButton(
            onPressed: () {},
            child: Text('เลือก'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[200],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  BottomNavBar({required this.onItemTapped, required this.selectedIndex});

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
      //currentIndex: selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      backgroundColor: Colors.grey[300],
      onTap: onItemTapped,
    );
  }
}

// Admin2 UI for reference
class Admin2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลสลากลอตเตอรี่'),
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
      bottomNavigationBar: BottomNavBar(
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pop(context); // Navigate back to admin1
          }
        },
        selectedIndex: 1,
      ),
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
