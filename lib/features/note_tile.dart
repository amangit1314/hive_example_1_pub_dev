import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  final String? title;
  final String? content;
  final bool isCompleted;
  final int id;

  const NoteTile({
    super.key,
    this.title,
    this.content,
    this.isCompleted = false,
    this.id = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff987654),
        ),
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // indicator should active if we are on it
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .06),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .009,
              ),
              Text(
                content ?? '',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.done),
          ),
        ],
      ),
    );
  }
}
