import 'package:flutter/material.dart';

import '../firebase/session_service.dart';

class SessionSummary extends StatefulWidget {
  const SessionSummary({Key? key}) : super(key: key);

  @override
  _SessionSummaryState createState() => _SessionSummaryState();
}

class _SessionSummaryState extends State<SessionSummary> {
  Future<Map<DateTime, int>>? _studyTimesFuture;

  @override
  void initState() {
    super.initState();
    _studyTimesFuture =
        fetchDailyStudyTime(); // Ensure this method is available and correct
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Statistics"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Map<DateTime, int>>(
        future: _studyTimesFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error.toString()}");
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No study data available."));
          }
          var dailyStudyTimes = snapshot.data!;
          return ListView.builder(
            itemCount: dailyStudyTimes.length,
            itemBuilder: (context, index) {
              DateTime dateKey = dailyStudyTimes.keys.elementAt(index);
              int totalSeconds = dailyStudyTimes[dateKey]!;
              int totalMinutes = totalSeconds ~/ 60;
              int hours = totalMinutes ~/ 60;
              int minutes = totalMinutes % 60;

              return ListTile(
                title: Text("${dateKey.day}/${dateKey.month}/${dateKey.year}"),
                subtitle: Text("Studied for ${hours}h ${minutes}m"),
              );
            },
          );
        },
      ),
    );
  }
}
