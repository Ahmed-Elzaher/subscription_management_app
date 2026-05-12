import 'package:flutter/material.dart';

class HeaderCard extends StatefulWidget {
  final double totalSpend;
  final String currency;

  const HeaderCard({super.key, required this.totalSpend, this.currency = '\$'});

  @override
  State<HeaderCard> createState() => _HeaderCardState();
}

class _HeaderCardState extends State<HeaderCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.95; // تصغير بسيط لما تضغط
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _scale = 1.0; // ترجع لحجمها الطبيعي لما ترفع إيدك
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0; // تأمين لو السحبة خرجت بره الويدجت
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        // تقدر تفتح الـ Insights هنا لو حابب
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100), // سرعة الحركة
        curve: Curves.easeInOut,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF0061FF).withOpacity(0.8),
                const Color(0xFF003366)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0061FF).withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Spend',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                      '${widget.currency}${widget.totalSpend.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w900)),
                  const SizedBox(width: 8),
                  const Text('USD',
                      style: TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildHeaderButton(Icons.add, 'Add Plan'),
                  const SizedBox(width: 12),
                  _buildHeaderButton(Icons.bar_chart, 'Insights'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderButton(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}