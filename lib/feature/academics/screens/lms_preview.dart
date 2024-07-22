import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => TabScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LMS'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'TOA'),
              Tab(text: 'NA'),
              Tab(text: 'LA'),
              Tab(text: 'CAL'),
              Tab(text: 'SI'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(context, 'TOA'),
            _buildTabContent(context, 'NA'),
            _buildTabContent(context, 'LA'),
            _buildTabContent(context, 'CAL'),
            _buildTabContent(context, 'SI'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String tabLabel) {
    final buttons = [
      'Syllabus',
      'Announcements',
      'Resources',
      'Assignments',
      'Dropbox',
      'Site Info',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Container
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subject Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This is an overview of the subject $tabLabel. Here you can include detailed information about the subject, its objectives, topics covered, and other relevant details.',
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Generate ListTile items with buttons
            ...List.generate(
              buttons.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(buttons[index]),
                    subtitle: Text('Details about ${buttons[index]}'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
