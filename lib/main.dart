import 'package:flutter/material.dart';
void main() => runApp(const MokshaProApp());

class MokshaProApp extends StatelessWidget {
  const MokshaProApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  final pages = const [RoomsTab(), ChatTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "الغرف"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "الرسائل"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
        ],
      ),
    );
  }
}

class RoomsTab extends StatelessWidget {
  const RoomsTab({super.key});
  @override
  Widget build(BuildContext context) {
    final rooms = [
      {"name": "سهرة موكشا", "users": 24, "img": "🔥"},
      {"name": "ضحك وهزار", "users": 12, "img": "😂"},
      {"name": "نقاش جاد", "users": 8, "img": "☕"},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text("Moksha Voice Pro - المرحلة 1")),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (c, i) => Card(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: Text(rooms[i]["img"] as String, style: const TextStyle(fontSize: 30)),
            title: Text(rooms[i]["name"] as String),
            subtitle: Text("${rooms[i]["users"]} متواجد • لايف"),
            trailing: const Icon(Icons.mic, color: Colors.green),
            onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => VoiceRoomScreen(roomName: rooms[i]["name"] as String))),
          ),
        ),
      ),
    );
  }
}

class VoiceRoomScreen extends StatelessWidget {
  final String roomName;
  const VoiceRoomScreen({super.key, required this.roomName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(roomName)),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 0.8),
              itemCount: 8,
              itemBuilder: (c, i) {
                bool busy = i < 2;
                return Column(
                  children: [
                    CircleAvatar(radius: 30, backgroundColor: busy ? Colors.purple : Colors.grey[800], child: Icon(busy ? Icons.person : Icons.add, size: 30)),
                    const SizedBox(height: 6),
                    Text(busy ? "يوزر ${i + 1}" : "مقعد ${i + 1}", style: const TextStyle(fontSize: 12)),
                  ],
                );
              },
            ),
          ),
          Container(height: 120, color: Colors.black26, padding: const EdgeInsets.all(10), child: Row(children: [IconButton(icon: const Icon(Icons.mic, color: Colors.green, size: 32), onPressed: () {}), const Expanded(child: TextField(decoration: InputDecoration(hintText: "اكتب رسالة...", border: OutlineInputBorder()))), IconButton(icon: const Icon(Icons.card_giftcard, color: Colors.amber), onPressed: () {})])),
        ],
      ),
    );
  }
}

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("الرسائل")), body: const Center(child: Text("الرسائل - المرحلة 2")));
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text("البروفايل")), body: const Center(child: Text("ID: 10001 - Moksha User")));
}
