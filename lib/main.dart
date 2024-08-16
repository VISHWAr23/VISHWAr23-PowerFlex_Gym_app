import 'package:flutter/material.dart';

void main() {
  runApp(const GymApp());
}

class GymApp extends StatelessWidget {
  const GymApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PowerFlex Gym',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red[700],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.red[700],
          secondary: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
          bodyLarge: TextStyle(color: Colors.black87),
          titleLarge: TextStyle(color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red[700],
            foregroundColor: Colors.white,
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: const GymLandingPage(),
    );
  }
}

class GymLandingPage extends StatefulWidget {
  const GymLandingPage({Key? key}) : super(key: key);

  @override
  _GymLandingPageState createState() => _GymLandingPageState();
}

class _GymLandingPageState extends State<GymLandingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Colors.red[700],
            elevation: 4,
            toolbarHeight: 80.0,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
              title: const Text('PowerFlex Gym'),
              background: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/gym_home.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildNavButton('Home', () => _scrollToSection(0)),
                        _buildNavButton('Classes', () => _scrollToSection(1)),
                        _buildNavButton('Memberships', () => _scrollToSection(2)),
                        _buildNavButton('Contact', () => _scrollToSection(3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              const HeroSection(),
              const ClassesSection(),
              const MembershipsSection(),
              const ContactSection(),
              const Footer(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(title, style: const TextStyle(color: Colors.white)),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.3)),
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    final sectionHeight = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      sectionHeight * index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Transform Your Body, Transform Your Life',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Join PowerFlex Gym and start your fitness journey today!',
            style: TextStyle(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildAnimatedButton('Join Now'),
        ],
      ),
    );
  }
}

class ClassesSection extends StatelessWidget {
  const ClassesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Our Classes',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              ClassCard(
                icon: Icons.fitness_center,
                title: 'Strength Training',
                description: 'Build muscle and increase your strength',
              ),
              ClassCard(
                icon: Icons.directions_run,
                title: 'Cardio',
                description: 'Improve your endurance and burn calories',
              ),
              ClassCard(
                icon: Icons.self_improvement,
                title: 'Yoga',
                description: 'Enhance flexibility and reduce stress',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClassCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;

  const ClassCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _ClassCardState createState() => _ClassCardState();
}

class _ClassCardState extends State<ClassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 300,
        child: Card(
          elevation: _isHovered ? 16 : 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Icon(widget.icon, size: 48, color: Colors.red),
                const SizedBox(height: 8),
                Text(widget.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text(widget.description, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MembershipsSection extends StatelessWidget {
  const MembershipsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Membership Plans',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              MembershipCard(
                name: 'Basic',
                description: 'Access to gym equipment and basic classes',
                price: '\$49/month',
              ),
              MembershipCard(
                name: 'Premium',
                description: 'Full access to all classes and personal training sessions',
                price: '\$99/month',
              ),
              MembershipCard(
                name: 'Family',
                description: 'Membership for up to 4 family members',
                price: '\$179/month',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MembershipCard extends StatefulWidget {
  final String name;
  final String description;
  final String price;

  const MembershipCard({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
  }) : super(key: key);

  @override
  _MembershipCardState createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 300,
        child: Card(
          elevation: _isHovered ? 16 : 8,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text(widget.description, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 8),
                Text(widget.price, style: const TextStyle(fontSize: 18, color: Colors.red)),
                const SizedBox(height: 16),
                _buildAnimatedButton('Choose Plan'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildTextField('Name'),
          const SizedBox(height: 10),
          _buildTextField('Email'),
          const SizedBox(height: 10),
          _buildTextField('Message', maxLines: 3),
          const SizedBox(height: 20),
          _buildAnimatedButton('Send Message'),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red[700]!),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
    color: Colors.red[700],
    child: Wrap(
    spacing: 20,
    runSpacing: 20,
    alignment: WrapAlignment.spaceAround,
    children: [
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
    Text('PowerFlex Gym', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    SizedBox(height: 8),
    Text('123 Fitness Street', style: TextStyle(color: Colors.white70)),
    Text('GymCity, GC 12345', style: TextStyle(color: Colors.white70)),
    Text('Phone: (555) 123-4567', style: TextStyle(color: Colors.white70)),
    ],
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    const SizedBox(height: 8),
    _buildFooterLink('Home'),
    _buildFooterLink('Classes'),
    _buildFooterLink('Memberships'),
    _buildFooterLink('Contact'),
    ],
    ),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const Text('Follow Us', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
    const SizedBox(height: 8),
    _buildFooterLink('Facebook'),
    _buildFooterLink('Instagram'),
    _buildFooterLink('Twitter'),
      _buildFooterLink('YouTube'),
    ],
    ),
    ],
    ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {},
        child: Text(text, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}

Widget _buildAnimatedButton(String text) {
  return ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.red[700]),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return Colors.red[600];
          return null;
        },
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16),
    ),
  );
}