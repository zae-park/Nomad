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
