import 'package:flutter/material.dart';
import 'package:food_recipe/screens/widget/background_decoration.dart';
import 'package:food_recipe/screens/widget/top_nav_bar.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final Color _pinkColor = const Color(0xFFEC407A);
  final Color _backgroundColor = const Color.fromARGB(255, 247, 230, 235);
  
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _securityAlerts = true;
  bool _promotionalEmails = false;
  bool _newsletter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
       appBar: const TopNavBar(
      ),
      body: Stack(
        children: [
          const BackgroundDecoration(),
          Column(
            children: [
              
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Notification Settings Card
                      _buildSettingsCard(),
                      
                      const SizedBox(height: 25),
                      
                      // Recent Notifications
                      Text(
                        'Recent Notifications',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _pinkColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Notification List
                      _buildNotificationList(),
                      
                      const SizedBox(height: 25),
                      
                      // Notification Preferences
                      Text(
                        'Notification Preferences',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: _pinkColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      // Preferences List
                      _buildPreferencesCard(),
                      
                      const SizedBox(height: 30),
                      
                      // Clear All Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _showClearDialog();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _pinkColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            shadowColor: _pinkColor.withOpacity(0.3),
                          ),
                          child: const Text(
                            'Clear All Notifications',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _pinkColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: _pinkColor, size: 24),
              const SizedBox(width: 10),
              Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _pinkColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Email Notifications
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Receive notifications via email',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _emailNotifications,
                activeColor: _pinkColor,
                onChanged: (value) {
                  setState(() {
                    _emailNotifications = value;
                  });
                },
              ),
            ],
          ),
          const Divider(height: 30),
          
          // Push Notifications
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Push Notifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Receive push notifications',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _pushNotifications,
                activeColor: _pinkColor,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationList() {
    final notifications = [
      {
        'icon': Icons.security,
        'title': 'Security Alert',
        'message': 'New login from Chrome on Windows',
        'time': '2 minutes ago',
        'isUnread': true,
        'color': Colors.red,
      },
      {
        'icon': Icons.email,
        'title': 'Welcome Email',
        'message': 'Welcome to Legin! Confirm your email address',
        'time': '1 hour ago',
        'isUnread': false,
        'color': _pinkColor,
      },
      {
        'icon': Icons.person_add,
        'title': 'New Follower',
        'message': 'John Doe started following you',
        'time': '3 hours ago',
        'isUnread': false,
        'color': Colors.blue,
      },
      {
        'icon': Icons.update,
        'title': 'App Update',
        'message': 'New version 2.5.0 is available',
        'time': '1 day ago',
        'isUnread': false,
        'color': Colors.green,
      },
      {
        'icon': Icons.card_giftcard,
        'title': 'Special Offer',
        'message': 'Get 20% off on premium features',
        'time': '2 days ago',
        'isUnread': false,
        'color': Colors.orange,
      },
    ];

    return Column(
      children: notifications.map((notification) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification['isUnread'] as bool
                ? _pinkColor.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: notification['isUnread'] as bool
                  ? _pinkColor.withOpacity(0.3)
                  : Colors.grey[200]!,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (notification['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  notification['icon'] as IconData,
                  color: notification['color'] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          notification['title'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: notification['isUnread'] as bool
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: notification['isUnread'] as bool
                                ? Colors.black
                                : Colors.grey[800],
                          ),
                        ),
                        if (notification['isUnread'] as bool) ...[
                          const SizedBox(width: 8),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _pinkColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification['time'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey[500],
                ),
                onPressed: () {},
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPreferencesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: _pinkColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Security Alerts
          _buildPreferenceRow(
            'Security Alerts',
            'Get notified about security updates',
            _securityAlerts,
            (value) {
              setState(() {
                _securityAlerts = value;
              });
            },
          ),
          const Divider(height: 20),
          
          // Promotional Emails
          _buildPreferenceRow(
            'Promotional Emails',
            'Receive offers and promotions',
            _promotionalEmails,
            (value) {
              setState(() {
                _promotionalEmails = value;
              });
            },
          ),
          const Divider(height: 20),
          
          // Newsletter
          _buildPreferenceRow(
            'Newsletter',
            'Weekly updates and tips',
            _newsletter,
            (value) {
              setState(() {
                _newsletter = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceRow(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: _pinkColor,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Clear All Notifications',
          style: TextStyle(color: _pinkColor),
        ),
        content: const Text(
          'Are you sure you want to clear all notifications? This action cannot be undone.',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear notifications logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All notifications cleared'),
                  backgroundColor: _pinkColor,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _pinkColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}