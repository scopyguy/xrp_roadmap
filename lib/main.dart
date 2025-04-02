import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'snake_game.dart';

void main() {
  runApp(MemeTokenRoadmapApp());
}

class MemeTokenRoadmapApp extends StatelessWidget {
  const MemeTokenRoadmapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Token Roadmap',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.greenAccent,
          elevation: 10,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        '/home': (context) => RoadmapScreen(),
        '/snake_game': (context) => SnakeGame(),
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/background.png',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
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
      drawer: _buildDrawer(context),
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
                      Color.fromARGB(255, 121, 211, 168)
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
                child: Column(
                  children: [
                    Text(
                      '🐍 XRPython Cult',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'The Year of the Snake Begins! 🔥',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/snake_game');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Buy Token',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            _buildRoadmapItem(
              '🟢 Phase 1: Foundation & Ecosystem Growth (Ongoing - Q1 2024)',
              '''
✅ Community Takeover & Expansion – Meme energy fuels the movement!
✅ Venom Protocol Launch – Anti-scam verification system & Hiss List.
✅ LP Rewards System – "The Snake Pit" launches with 1T XRPython allocated for liquidity providers.
✅ Diamond Hands Reward System – Exclusive Telegram perks for long-term holders.
✅ XRPL Strategic Collaborations – Partnerships with BOOXRPL & DCC, expanding beyond crypto.
✅ Play-to-Earn Snake Game – Early Development – Bringing nostalgic gaming to blockchain.
              ''',
            ),
            _buildRoadmapItem(
              '🔵 Phase 2: The Rift Opens – Memes Made Real (Q2 2024 - Q1 2025)',
              '''
🛠️ 3D-Printed Meme Figures Begin Production

First collectible: XRPython figure – The Golden Snake emerges from the rift!
BOOXRPL Figure joins the cult – The haunting ghost materializes!
Figures designed & produced in the Netherlands, expanding the real-world presence.
🛍️ Webstore Development Begins

Official XRPython Cult Store – Selling 3D-printed meme collectibles, exclusive merch & community-driven items.
Sustainable funding model – Profits reinvested into ecosystem expansion & token stability.
Cross-chain accessibility – Expanding XRPython beyond XRPL.
📍 Interactive Roadmap App Launch

Community-driven progress tracking.
Voting system for future developments.
Increased transparency & engagement.
🎮 P2E Snake Game Development Continues

Prototype gameplay testing.
NFT-based skins & in-game customization.
Earning mechanics for XPTN integration.
🚀 More Strategic Partnerships

Expanding Venom Protocol verification to more XRPL projects.
More figure collaborations with meme-based projects.
              ''',
            ),
            _buildRoadmapItem(
              '🟣 Phase 3: The Grand Awakening (Q2 - Q4 2025 & Beyond)',
              '''
🔥 April 14, 2025 – XRPython Cult Webstore Grand Opening!

Mass production of meme figures.
New exclusive releases & limited-edition collectibles.
First major launch event with community rewards!
📈 Scaling Up Ecosystem Utility

P2E Game Launch with XRPython Token Integration.
Upgraded interactive roadmap with decentralized voting.
Cross-chain expansion & NFT-based reward systems.
👁️ The Cult Grows – More Rift Passages Open

More meme tokens will be immortalized in reality!
XRPython becomes a leader in blockchain-powered physical collectibles.
The Meme Revolution of 2025 solidifies its mark.
              ''',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'XRPython Cult',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome to the Movement',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blueAccent),
              title: Text('Introduction'),
              onTap: () {
                Navigator.pop(context);
                _showIntro(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.map, color: Colors.blueAccent),
              title: Text('Roadmap'),
              onTap: () {
                Navigator.pop(context);
                _showRoadmap(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.gamepad, color: Colors.blueAccent),
              title: Text('Game Section'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/snake_game');
              },
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard,
                  color: const Color.fromARGB(255, 145, 181, 241)),
              title: Text('Rewards'),
              onTap: () {
                Navigator.pop(context);
                _showReward(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.blueAccent),
              title: Text('Social'),
              onTap: () {
                Navigator.pop(context);
                _showSocialLinks(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReward(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Snake Pit LP Reward Program",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🚀 XRPython is growing, and we are rewarding those who help strengthen our liquidity! To ensure a stable and thriving market, we’re launching the Snake Pit LP Reward Program—where long-term liquidity providers (LPs) get rewarded monthly!",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                Text(
                  "💎 1 TRILLION XRPython has been allocated for LP rewards over the next 10 months!",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 24),
                _buildRoadmapItem(
                  '🐍 How It Works',
                  '''
✅ Provide liquidity in the official XRPython LP pool (XRPython + XRP).
✅ Join the LP Provider Group Chat (Exclusive for LPs).
✅ On the 1st of each month, submit a screenshot of your LP position & wallet address.
✅ Our team verifies LPs and announces the Top 3 providers.
✅ Rewards are distributed directly by the team!
                ''',
                ),
                SizedBox(height: 16),
                _buildRoadmapItem(
                  '📢 Monthly Rewards Breakdown: 100 Billion XRPython per month!',
                  '''
🥇 1st Place LP: 50B XRPython (50%)
🥈 2nd Place LP: 30B XRPython (30%)
🥉 3rd Place LP: 20B XRPython (20%)
                ''',
                ),
                SizedBox(height: 16),
                Text(
                  "⏳ The longer you provide liquidity, the higher your chances of earning rewards! This system favors long-term holders over short-term LP flippers.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showIntro(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Introduction to XRPython",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🐍 XRPython – The Fastest Snake on XRPL!\n\n"
                  "📜 Overview\n"
                  "XRPython is a meme-driven, community-controlled token built on the XRP Ledger (XRPL). "
                  "Inspired by the Year of the Snake, XRPython represents speed, strategy, and unstoppable momentum!\n\n"
                  "📊 Tokenomics Breakdown:\n"
                  "🔹 Total Supply: 999,000,000,000 XPTN\n"
                  "🔹 Initial Liquidity: 100 XRP\n"
                  "🔹 Transaction Fees: 0%\n"
                  "🔹 Blockchain: XRPL (fast & fee-less)\n\n"
                  "🔥 Why XRPython?\n"
                  "✅ No Presale, No Team Control\n"
                  "✅ Fast, Fee-Less Transactions\n"
                  "✅ Deflationary Tokenomics (Burn & Lock Strategy)\n"
                  "✅ Play-to-Earn Game in 2025\n\n",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showRoadmap(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "🐍 XRPython 2024-2025 Roadmap – The Year of the Snake Begins! 🔥",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  "XRPython is not just a token—it’s a movement. A fusion of digital and physical worlds, creating a self-sustaining ecosystem that goes beyond speculation. Here's a detailed roadmap based on all the initiatives in development!",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 24),
                _buildRoadmapItem(
                  '🟢 Phase 1: Foundation & Ecosystem Growth (Ongoing - Q1 2024)',
                  '''
✅ Community Takeover & Expansion – Meme energy fuels the movement!
✅ Venom Protocol Launch – Anti-scam verification system & Hiss List.
✅ LP Rewards System – "The Snake Pit" launches with 1T XRPython allocated for liquidity providers.
✅ Diamond Hands Reward System – Exclusive Telegram perks for long-term holders.
✅ XRPL Strategic Collaborations – Partnerships with BOOXRPL & DCC, expanding beyond crypto.
✅ Play-to-Earn Snake Game – Early Development – Bringing nostalgic gaming to blockchain.
                ''',
                ),
                _buildRoadmapItem(
                  '🔵 Phase 2: The Rift Opens – Memes Made Real (Q2 2024 - Q1 2025)',
                  '''
🛠️ 3D-Printed Meme Figures Begin Production

First collectible: XRPython figure – The Golden Snake emerges from the rift!
BOOXRPL Figure joins the cult – The haunting ghost materializes!
Figures designed & produced in the Netherlands, expanding the real-world presence.
🛍️ Webstore Development Begins

Official XRPython Cult Store – Selling 3D-printed meme collectibles, exclusive merch & community-driven items.
Sustainable funding model – Profits reinvested into ecosystem expansion & token stability.
Cross-chain accessibility – Expanding XRPython beyond XRPL.
📍 Interactive Roadmap App Launch

Community-driven progress tracking.
Voting system for future developments.
Increased transparency & engagement.
🎮 P2E Snake Game Development Continues

Prototype gameplay testing.
NFT-based skins & in-game customization.
Earning mechanics for our XPTN integration.
🚀 More Strategic Partnerships

Expanding Venom Protocol verification to more XRPL projects.
More figure collaborations with meme-based projects.
                ''',
                ),
                _buildRoadmapItem(
                  '🟣 Phase 3: The Grand Awakening (Q2 - Q4 2025 & Beyond)',
                  '''
🔥 April 14, 2025 – XRPython Cult Webstore Grand Opening!

Mass production of meme figures.
New exclusive releases & limited-edition collectibles.
First major launch event with community rewards!
📈 Scaling Up Ecosystem Utility

P2E Game Launch with XRPython Token Integration.
Upgraded interactive roadmap with decentralized voting.
Cross-chain expansion & NFT-based reward systems.
👁️ The Cult Grows – More Rift Passages Open

More meme tokens will be immortalized in reality!
XRPython becomes a leader in blockchain-powered physical collectibles.
The Meme Revolution of 2025 solidifies its mark.
                ''',
                ),
                SizedBox(height: 16),
                Text(
                  "🚀 The Future of XRPython – A True Meme Ecosystem",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 8),
                Text(
                  "XRPython is leading the way in bridging memes, blockchain, and reality. No longer just a token, it is now a self-sustaining cultural movement with real-world presence.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 8),
                Text(
                  "🔗 From code to collectibles.\n🔥 From speculation to sustainability.\n🐍 From digital memes to real-world legends.",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                SizedBox(height: 16),
                Text(
                  "🚀 The Rift is Open – Will You Step Through?",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 8),
                Text(
                  "🗓️ April 14, 2025 – The Next Phase Begins!",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void _showSocialLinks(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Social Links'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.link, color: Colors.blueAccent),
                title: Text('X (Twitter)'),
                onTap: () => _launchURL(xLinkUrl),
              ),
              ListTile(
                leading: Icon(Icons.telegram, color: Colors.blueAccent),
                title: Text('Telegram'),
                onTap: () => _launchURL(telegramLinkUrl),
              ),
            ],
          ),
        );
      },
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
