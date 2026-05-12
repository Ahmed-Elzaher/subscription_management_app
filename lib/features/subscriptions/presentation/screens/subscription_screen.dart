import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/header_card.dart';
import '../widgets/category_selector.dart';
import '../widgets/subscription_list.dart';
import '../../data/models/subscription_model.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selectedCategory = 'All';

  // روابط صور مباشرة ونظيفة للوجوهات الأصلية
  final List<SubscriptionModel> mockSubscriptions = [
    SubscriptionModel(
      id: '1', name: 'Netflix', price: 15.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 7)),
      category: 'Entertainment', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/732/732228.png', // Netflix PNG
    ),
    SubscriptionModel(
      id: '2', name: 'Spotify', price: 11.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 14)),
      category: 'Entertainment', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/174/174872.png', // Spotify PNG
    ),
    SubscriptionModel(
      id: '3', name: 'Discord', price: 54.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 10)),
      category: 'Business', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/5968/5968756.png', // Adobe PNG
    ),
    SubscriptionModel( 
      id: '4', name: 'ChatGPT Plus', price: 20.00, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 12)),
      category: 'Business', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/12222/12222560.png', // ChatGPT PNG
    ),
    SubscriptionModel(
      id: '5', name: 'YouTube', price: 13.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 20)),
      category: 'Entertainment', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/1384/1384060.png', // YouTube PNG
    ),
    SubscriptionModel(
      id: '6', name: 'PS Plus', price: 14.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 3)),
      category: 'Entertainment', isActive: false,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/588/588258.png', // Amazon PNG
    ),
    SubscriptionModel(
      id: '7', name: 'Microsoft 365', price: 9.99, currency: '\$',
      renewalDate: DateTime.now().add(const Duration(days: 5)),
      category: 'Business', isActive: true,
      iconUrl: 'https://cdn-icons-png.flaticon.com/512/732/732221.png', // Microsoft PNG
    ),
  ];

  List<SubscriptionModel> get _filteredSubscriptions {
    if (_selectedCategory == 'All') return mockSubscriptions;
    return mockSubscriptions.where((sub) => sub.category == _selectedCategory).toList();
  }

  double _calculateTotalSpend() {
    return _filteredSubscriptions.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Subscriptions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: CircleAvatar(backgroundColor: Color(0xFF1A1A1A), child: Icon(Icons.person_outline_rounded, color: Colors.white)),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      HeaderCard(totalSpend: _calculateTotalSpend()),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 40, 
                        child: CategorySelector(
                          categories: const ['All', 'Entertainment', 'Business', 'Cloud'],
                          selectedCategory: _selectedCategory,
                          onCategoryChanged: (cat) => setState(() => _selectedCategory = cat),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SubscriptionList(subscriptions: _filteredSubscriptions),
                const SizedBox(height: 180),
              ],
            ),
          ),
          // ويدجت الـ Quick Stats المضيئة
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildInteractiveQuickStats(),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveQuickStats() {
    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.blueAccent.withOpacity(0.15), blurRadius: 40, offset: const Offset(0, -10))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // تعديل المسافات
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A).withOpacity(0.8),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _interactiveTile('Active', '${_filteredSubscriptions.where((s) => s.isActive).length}', Icons.bolt_rounded, Colors.amber),
                    _interactiveTile('Monthly', '\$${_calculateTotalSpend().toStringAsFixed(0)}', Icons.account_balance_wallet_rounded, Colors.greenAccent),
                    _interactiveTile('Next', 'Adobe', Icons.event_repeat_rounded, Colors.blueAccent),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _interactiveTile(String label, String val, IconData icon, Color color) {
    return _BounceWidget(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10), // تصغير الحجم قليلاً
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15)),
        ],
      ),
    );
  }
}

class _BounceWidget extends StatefulWidget {
  final Widget child;
  const _BounceWidget({required this.child});
  @override
  State<_BounceWidget> createState() => _BounceWidgetState();
}
class _BounceWidgetState extends State<_BounceWidget> {
  double _s = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _s = 0.95), // Bounce تأثير أخف
      onTapUp: (_) => setState(() => _s = 1.0),
      child: AnimatedScale(scale: _s, duration: const Duration(milliseconds: 100), child: widget.child),
    );
  }
}