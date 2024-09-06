import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyBagScreen(),
    );
  }
}

class MyBagScreen extends StatefulWidget {
  const MyBagScreen({super.key});

  @override
  _MyBagScreenState createState() => _MyBagScreenState();
}

class _MyBagScreenState extends State<MyBagScreen> {
  int pulloverQty = 1;
  int tshirtQty = 1;
  int sportDressQty = 1;

  final int pulloverPrice = 51;
  final int tshirtPrice = 30;
  final int sportDressPrice = 43;

  int get totalAmount {
    return (pulloverQty * pulloverPrice) +
        (tshirtQty * tshirtPrice) +
        (sportDressQty * sportDressPrice);
  }

  void increaseQty(Function setQty, int currentQty) {
    setState(() {
      setQty(currentQty + 1);
    });
  }

  void decreaseQty(Function setQty, int currentQty) {
    if (currentQty > 1) {
      setState(() {
        setQty(currentQty - 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Bag'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildCartItem('Pullover', 'Black', 'L', pulloverQty,
                        pulloverPrice, (qty) => pulloverQty = qty, 'https://img.freepik.com/premium-photo/black-tshirt-hanging-white-wall-simple-minimalistic-clothing-display_194498-14008.jpg'),
                    buildCartItem('T-Shirt', 'Gray', 'L', tshirtQty, tshirtPrice,
                            (qty) => tshirtQty = qty, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdyGmpbM-5AyxAdfyqgF_oFSMmwxsa6U-pJg&s'),
                    buildCartItem('Sport Dress', 'Black', 'M', sportDressQty,
                        sportDressPrice, (qty) => sportDressQty = qty, 'https://img.freepik.com/premium-photo/black-tshirt-hanging-white-wall-simple-minimalistic-clothing-display_194498-14008.jpg'),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildTotalAmount(),
                const SizedBox(height: 10),
                buildCheckoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCartItem(String itemName, String color, String size, int qty,
      int price, Function setQty, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(itemName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('Color: $color', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                    const SizedBox(width: 16),
                    Text('Size: $size', style: const TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => decreaseQty(setQty, qty),
                    ),
                    Text(qty.toString(), style: const TextStyle(fontSize: 20)),
                    IconButton(
                      iconSize: 30,
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => increaseQty(setQty, qty),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Icon(Icons.more_vert, size: 28),
              const SizedBox(height: 56),
              Align(
                alignment: Alignment.bottomRight,
                child: Text('\$$price', style: const TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTotalAmount() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total amount:', style: TextStyle(fontSize: 22)),
          Text('\$$totalAmount', style: const TextStyle(fontSize: 22)),
        ],
      ),
    );
  }

  Widget buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        const snackBar = SnackBar(
          content: Text('Congratulations! Your order is placed.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: const Center(
        child: Text(
          'CHECK OUT',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}