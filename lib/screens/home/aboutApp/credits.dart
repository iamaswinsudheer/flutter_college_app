import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height * 0.02,
            horizontal: screenSize.width * 0.02),
        children: [
          Text(
            'We acknowledge and thank the following creators.',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(
            height: screenSize.height * 0.03,
          ),
          AttributionTile(
              title: 'Student Icon',
              body: 'Student icon made by Aficons studio from flaticon.',
              link: 'https://www.flaticon.com/free-icons/student'),
          AttributionTile(
              title: 'Open Book Icons',
              body: 'Open book icons made by Karyative from flaticon.',
              link: 'https://www.flaticon.com/free-icons/open-book'),
          AttributionTile(
              title: 'Education And Online Learning Flat Concept',
              body: 'illustration PNG Designed By RedvyCreative from pngtree.',
              link:
                  'https://pngtree.com/freepng/education-and-online-learning-flat-concept_5373900.html?sol=downref&id=bef?sol=downref&id=bef'),
        ],
      ),
    );
  }
}

class AttributionTile extends StatelessWidget {
  final String title;
  final String body;
  final String link;

  AttributionTile(
      {required this.title, required this.body, required this.link});

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800]),
          ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
          Text(body),
          Text(link),
          Divider(
            height: screenSize.height * 0.04,
          ),
        ],
      ),
    );
  }
}
