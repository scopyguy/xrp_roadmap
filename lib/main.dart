import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import 'in_app_purchase.dart';
import 'snake_game.dart'; // Ensure this file exists

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenSystem()),
        Provider(create: (_) => InAppPurchaseService()..init()),
      ],
      child: MemeTokenRoadmapApp(),
    ),
  );
}

class MemeTokenRoadmapApp extends StatelessWidget {
  const MemeTokenRoadmapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Token Roadmap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 10,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: RoadmapScreen(),
      routes: {
        '/snake_game': (context) => SnakeGame(),
      },
    );
  }
}

class RoadmapScreen extends StatefulWidget {
  @override
  _RoadmapScreenState createState() => _RoadmapScreenState();
}

class _RoadmapScreenState extends State<RoadmapScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final String buyTokenUrl =
      'https://firstledger.net/token/rD4erh2HEUJxFvghQmUfxqGo4wxZhMfd4g/505954484F4E0000000000000000000000000000';
  final String xLinkUrl = 'https://x.com/XRPhyton';
  final String telegramLinkUrl = 'https://t.me/XRPython';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meme Token Roadmap'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      const Color.fromARGB(255, 121, 211, 168)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  "INTRODUCTION TO OUR TOKEN\n"
                  "🐍 XRPython – The Fastest Snake on XRPL!\n"
                  "📜 Overview\n"
                  "XRPython is a meme-driven, community-controlled token built on the XRP Ledger (XRPL). Inspired by the Year of the Snake, XRPython represents speed, strategy, and unstoppable momentum in the crypto world. No team control, no VC funding—just pure meme energy and community takeover!\n\n"
                  "📊 Tokenomics Breakdown\n"
                  "🔹 Total Supply: 999,000,000,000 XPTN\n"
                  "🔹 Liquidity at Launch: 100 XRP (for better price stability)\n"
                  "🔹 Initial Price: ~ 1 XPTN = 0.0000000001 XRP (subject to market activity)\n"
                  "🔹 Transaction Fees: 0% (XRPL has no native tax system!)\n"
                  "🔹 Blockchain: XRP Ledger (XRPL) – fast, fee-less, and scalable\n\n"
                  "🔹 Dev Token Allocation:\n\n"
                  "50% of dev tokens burned (01/03/25) 🔥\n"
                  "50% locked in escrow for 3 months (until Q2 2025) 🔒\n"
                  "🔹 Play-to-Earn Utility:\n\n"
                  "XRPython will launch a classic Snake Game in Q2 2025, allowing users to play and earn XPTN rewards!\n"
                  "📅 Roadmap\n"
                  "🐍 Phase 1: The Awakening (Q1 2025)\n"
                  "✅ Website & Social Media Setup\n"
                  "✅ Token Creation & Fair Launch on XRPL\n"
                  "✅ Initial Liquidity Added (100 XRP)\n"
                  "✅ Viral Meme & Community Building\n\n"
                  "🔥 Phase 2: The Great Burn & Lock (01/03/2025)\n"
                  "🚀 50% of Dev Tokens Burned 🔥\n"
                  "🔒 50% Locked in Escrow for 3 Months\n"
                  "💬 Community Voting & Future Proposals\n\n"
                  "🎮 Phase 3: Play-to-Earn Game Launch (06/2025)\n"
                  "🎮 XRPython Snake Game Goes Live – Earn XPTN while playing!\n"
                  "🚀 Leaderboard Rewards & Competitions\n"
                  "🌎 Community Expansion & Partnerships\n\n"
                  "🐍 Phase 4: Future Growth & Enhancements (Late 2025 & Beyond)\n"
                  "🔄 Potential Strategic Burns\n"
                  "🌉 Possible Cross-Chain Bridges (if community votes)\n"
                  "🎁 Community-Driven Events & NFT Ideas\n\n"
                  "🔥 Why XRPython?\n"
                  "✅ Pure Meme Energy – No Presale, No Team Control\n"
                  "✅ Ultra-Fast, Fee-Less Transactions (Thanks to XRPL!)\n"
                  "✅ Deflationary Tokenomics – Burn & Lock Strategy\n"
                  "✅ Long-Term Vision – Play-to-Earn Utility Coming in 2025\n"
                  "✅ Community Takeover – You Decide What’s Next!\n\n"
                  "📢 Final Words:\n"
                  "🐍 Slither fast, strike hard, and HODL tight—XRPython is here to shake up XRPL! 🚀\n\n"
                  "Join the movement! #XRPython #SlitherFast #YearOfTheSnake",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),

            // Roadmap Section
            Text(
              'Roadmap',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16),
            _buildRoadmapItem('Phase 1: Token Launch',
                'Launch the meme token and build the community.'),
            _buildRoadmapItem('Phase 2: Marketing',
                'Aggressive marketing on social media platforms.'),
            _buildRoadmapItem('Phase 3: Partnerships',
                'Partner with influencers and other projects.'),
            _buildRoadmapItem('Phase 4: Ecosystem Expansion',
                'Develop utilities and use cases for the token.'),
            SizedBox(height: 20),

            // Buttons Section
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/snake_game');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Play Snake Game',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _launchURL(buyTokenUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Buy Token',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Social Links Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.link, color: Colors.blueAccent),
                  onPressed: () => _launchURL(xLinkUrl),
                  tooltip: 'X (Twitter) Link',
                ),
                IconButton(
                  icon: Icon(Icons.telegram, color: Colors.blueAccent),
                  onPressed: () => _launchURL(telegramLinkUrl),
                  tooltip: 'Telegram Link',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoadmapItem(String title, String description) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// Token System Implementation
class TokenSystem with ChangeNotifier {
  int _tokens = 0;

  int get tokens => _tokens;

  void earnTokens(int amount) {
    _tokens += amount;
    notifyListeners();
  }

  void spendTokens(int amount) {
    _tokens -= amount;
    notifyListeners();
  }
}
