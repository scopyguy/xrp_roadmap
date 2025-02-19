import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xrp_roadmap/in_app_purchase.dart'; // Only import if necessary

class SnakeGame extends StatefulWidget {
  @override
  _SnakeGameState createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  late InAppPurchaseService _inAppPurchaseService;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _inAppPurchaseService = Provider.of<InAppPurchaseService>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake Game'),
      ),
      body: Center(
        child: Text('Snake Game will be here'),
      ),
    );
  }
}
