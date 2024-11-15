// lib/modules/home/views/top_up_options.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopUpOptions extends StatefulWidget {
  final String gameName;
  final Function(String title, String price) onSelectItem;

  TopUpOptions({required this.gameName, required this.onSelectItem});

  @override
  _TopUpOptionsState createState() => _TopUpOptionsState();
}

class _TopUpOptionsState extends State<TopUpOptions> {
  int? selectedIndex; // Untuk menyimpan index item yang dipilih

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> options = _getTopUpOptions(widget.gameName);

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        bool isSelected = index == selectedIndex;

        return Card(
          elevation: 4,
          color: isSelected ? Colors.blueAccent : Colors.white,
          child: InkWell(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onSelectItem(options[index]['title']!, options[index]['price']!);
              Get.snackbar(
                'Item Dipilih',
                'Anda memilih ${options[index]['title']} seharga ${options[index]['price']}',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    options[index]['title']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    options[index]['price']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, String>> _getTopUpOptions(String gameName) {
    List<Map<String, String>> options;

    if (gameName == 'Mobile Legends') {
      options = [
        {'title': '5 Diamonds', 'price': 'Rp 1.400'},
        {'title': '10 Diamonds', 'price': 'Rp 3.000'},
        {'title': '12 Diamonds', 'price': 'Rp 3.500'},
        {'title': '19 Diamonds', 'price': 'Rp 5.500'},
        {'title': '28 Diamonds', 'price': 'Rp 8.000'},
        {'title': '33 Diamonds', 'price': 'Rp 9.500'},
      ];
    } else if (gameName == 'PUBG') {
      options = [
        {'title': '60 UC', 'price': 'Rp 14.000'},
        {'title': '120 UC', 'price': 'Rp 28.000'},
        {'title': '325 UC', 'price': 'Rp 71.000'},
        {'title': '660 UC', 'price': 'Rp 142.500'},
        {'title': '1320 UC', 'price': 'Rp 285.000'},
        {'title': '1800 UC', 'price': 'Rp 356.000'},
      ];
    } else if (gameName == 'Honor of Kings') {
      options = [
        {'title': '8 Tokens', 'price': 'Rp 1.666'},
        {'title': '16 Tokens', 'price': 'Rp 3.666'},
        {'title': '23 Tokens', 'price': 'Rp 4.666'},
        {'title': '80+8 Tokens', 'price': 'Rp 14.666'},
        {'title': '240+17 Tokens', 'price': 'Rp 41.666'},
        {'title': '400+32 Tokens', 'price': 'Rp 131.666'},
      ];
    } else if (gameName == 'Growtopia') {
      options = [
        {'title': '5 DL', 'price': 'Rp 19.500'},
        {'title': '10 DL', 'price': 'Rp 39.000'},
        {'title': '20 DL', 'price': 'Rp 78.000'},
        {'title': '25 DL', 'price': 'Rp 97.500'},
        {'title': '30 DL', 'price': 'Rp 117.000'},
        {'title': '50 DL', 'price': 'Rp 195.000'},
      ];
    } else if (gameName == 'Free Fire') {
      options = [
        {'title': '12 Diamonds', 'price': 'Rp 2.000'},
        {'title': '50 Diamonds', 'price': 'Rp 8.000'},
        {'title': '70 Diamonds', 'price': 'Rp 10.000'},
        {'title': '100 Diamonds', 'price': 'Rp 15.000'},
        {'title': '140 Diamonds', 'price': 'Rp 19.000'},
        {'title': '355 Diamonds', 'price': 'Rp 47.000'},
      ];
    } else if (gameName == 'LOL: Wild Rift') {
      options = [
        {'title': '425 Wild Cores', 'price': 'Rp 60.000'},
        {'title': '1000 Wild Cores', 'price': 'Rp 125.000'},
        {'title': '1850 Wild Cores', 'price': 'Rp 220.000'},
        {'title': '3275 Wild Cores', 'price': 'Rp 375.000'},
        {'title': '4800 Wild Cores', 'price': 'Rp 535.000'},
        {'title': '6210 Wild Cores', 'price': 'Rp 750.000'},
      ];
    } else if (gameName == 'Valorant') {
      options = [
        {'title': '475 Points', 'price': 'Rp 55.000'},
        {'title': '950 Points', 'price': 'Rp 105.000'},
        {'title': '1475 Points', 'price': 'Rp 160.000'},
        {'title': '2050 Points', 'price': 'Rp 210.000'},
        {'title': '2525 Points', 'price': 'Rp 260.000'},
        {'title': '3050 Points', 'price': 'Rp 310.000'},
      ];
    } else if (gameName == 'Genshin Impact') {
      options = [
        {'title': 'Blessing of the Welkin Moon', 'price': 'Rp 60.000'},
        {'title': '60 Genesis Crystals', 'price': 'Rp 12.000'},
        {'title': '330 Genesis Crystals', 'price': 'Rp 64.000'},
        {'title': '1090 Genesis Crystals', 'price': 'Rp 192.000'},
        {'title': '3880 Genesis Crystals', 'price': 'Rp 640.000'},
        {'title': '8080 Genesis Crystals', 'price': 'Rp 1.280.000'},
      ];
    } else if (gameName == 'Call of Duty Mobile') {
      options = [
        {'title': '31 CP', 'price': 'Rp 5.000'},
        {'title': '62 CP', 'price': 'Rp 10.000'},
        {'title': '127 CP', 'price': 'Rp 20.000'},
        {'title': '1373 CP', 'price': 'Rp 195.000'},
        {'title': '2059 CP', 'price': 'Rp 295.000'},
        {'title': '3564 CP', 'price': 'Rp 480.000'},
        {'title': '7656 CP', 'price': 'Rp 960.000'},
      ];
    } else if (gameName == 'Arena of Valor') {
      options = [
        {'title': '40 Vouchers', 'price': 'Rp 9.500'},
        {'title': '90 Vouchers', 'price': 'Rp 19.500'},
        {'title': '230 Vouchers', 'price': 'Rp 49.000'},
        {'title': '470 Vouchers', 'price': 'Rp 99.000'},
        {'title': '950 Vouchers', 'price': 'Rp 195.000'},
      ];
    } else if (gameName == 'Point Blank') {
      options = [
        {'title': '1200 Cash', 'price': 'Rp 9.400'},
        {'title': '2400 Cash', 'price': 'Rp 18.700'},
        {'title': '6000 Cash', 'price': 'Rp 45.900'},
        {'title': '12000 Cash', 'price': 'Rp 99.700'},
        {'title': '24000 Cash', 'price': 'Rp 195.500'},
        {'title': '36000 Cash', 'price': 'Rp 293.200'},
        {'title': '60000 Cash', 'price': 'Rp 488.700'},
      ];
    } else if (gameName == 'Ragnarok M: Eternal Love') {
      options = [
        {'title': '6 Big Cat Coins', 'price': 'Rp 14.800'},
        {'title': '12 Big Cat Coins', 'price': 'Rp 29.500'},
        {'title': '18 Big Cat Coins', 'price': 'Rp 44.100'},
        {'title': '24 Big Cat Coins', 'price': 'Rp 58.900'},
        {'title': '36 Big Cat Coins', 'price': 'Rp 72.100'},
        {'title': '72 Big Cat Coins', 'price': 'Rp 139.700'},
        {'title': '145 Big Cat Coins', 'price': 'Rp 288.000'},
        {'title': '373 Big Cat Coins', 'price': 'Rp 734.000'},
      ];
    } else if (gameName == 'Stumble Guys') {
      options = [
        {'title': '120 Tokens', 'price': 'Rp 37.100'},
        {'title': '250 Gems', 'price': 'Rp 11.900'},
        {'title': '800 Gems', 'price': 'Rp 31.200'},
        {'title': '1300 Tokens', 'price': 'Rp 303.500'},
        {'title': '1600 Gems dan 75 Tokens', 'price': 'Rp 54.700'},
        {'title': '5000 Gems dan 275 Tokens', 'price': 'Rp 123.500'},
      ];
    } else {
      options = [];
    }
    return options;
  }
}
