import 'dart:ui';
import 'package:flutter/material.dart';
import '../../data/models/subscription_model.dart';

class SubscriptionItem extends StatelessWidget {
  final SubscriptionModel subscription;
  const SubscriptionItem({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04), // شفافية خفيفة جداً
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.08)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56, height: 56,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(18)),
                  child: Image.network(
                    subscription.iconUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.apps_rounded, color: Colors.white24),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(subscription.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                      const SizedBox(height: 4),
                      Text('Renews in ${subscription.renewalDate.day} days', style: const TextStyle(color: Colors.white38, fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${subscription.price}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 17)),
                    const SizedBox(height: 6),
                    Text(
                      subscription.isActive ? 'ACTIVE' : 'INACTIVE',
                      style: TextStyle(
                        color: subscription.isActive ? Colors.greenAccent : Colors.redAccent,
                        fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}