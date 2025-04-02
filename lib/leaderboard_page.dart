import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> getLeaderboard() async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboard = prefs.getStringList('leaderboard') ?? [];
    return leaderboard.map((entry) {
      final parts = entry.split(':');
      return {'name': parts[0], 'score': int.parse(parts[1])};
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final leaderboard = snapshot.data ?? [];
          return ListView.builder(
            itemCount: leaderboard.length,
            itemBuilder: (context, index) {
              final entry = leaderboard[index];
              return ListTile(
                title: Text(entry['name']),
                trailing: Text('Score: ${entry['score']}'),
              );
            },
          );
        },
      ),
    );
  }
}
