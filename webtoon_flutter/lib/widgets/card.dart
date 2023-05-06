import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Color bgColor;
  final String moneyName;
  final String moneyAbb;
  final IconData logo;
  final String amount;

  const MyCard({
    super.key,
    required this.moneyName,
    required this.moneyAbb,
    required this.amount,
    required this.bgColor,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: bgColor,
        shape: BoxShape.rectangle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  moneyName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      amount,
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      moneyAbb,
                      style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
            Transform.scale(
              scale: 3.14,
              child: Transform.translate(
                offset: const Offset(2, 8),
                child: Icon(
                  logo,
                  color: Colors.deepOrange,
                  size: 60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToonCard extends StatelessWidget {
  // final Color bgColor;
  final String toonName;
  final String thumbURL;
  final String toonID;
  // final IconData logo;

  const ToonCard({
    super.key,
    required this.toonName,
    required this.thumbURL,
    required this.toonID,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      clipBehavior: Clip.hardEdge,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 2.0,
                          strokeAlign: BorderSide.strokeAlignOutside),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ]),
                  child: Image.network(
                    thumbURL,
                    headers: const {
                      "User-Agent":
                          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  toonName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
