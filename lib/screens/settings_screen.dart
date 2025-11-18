import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _analyticsEnabled = true;
  double _fontSize = 16.0;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSection('Preferences', [
            _buildSwitchTile(
              'Notifications',
              'Receive push notifications',
              Icons.notifications,
              _notificationsEnabled,
              (value) => setState(() => _notificationsEnabled = value),
            ),
            _buildSwitchTile(
              'Dark Mode',
              'Use dark theme',
              Icons.dark_mode,
              _darkModeEnabled,
              (value) => setState(() => _darkModeEnabled = value),
            ),
            _buildSwitchTile(
              'Analytics',
              'Help improve the app',
              Icons.analytics,
              _analyticsEnabled,
              (value) => setState(() => _analyticsEnabled = value),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Appearance', [
            _buildSliderTile(
              'Font Size',
              'Adjust text size',
              Icons.text_fields,
              _fontSize,
              10.0,
              24.0,
              (value) => setState(() => _fontSize = value),
            ),
            _buildDropdownTile(
              'Language',
              'Select your language',
              Icons.language,
              _selectedLanguage,
              _languages,
              (value) => setState(() => _selectedLanguage = value!),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Account', [
            _buildActionTile(
              'Backup Data',
              'Save your data to cloud',
              Icons.backup,
              _backupData,
            ),
            _buildActionTile(
              'Clear Cache',
              'Free up storage space',
              Icons.cleaning_services,
              _clearCache,
            ),
            _buildActionTile(
              'Sign Out',
              'Sign out of your account',
              Icons.logout,
              _signOut,
              isDestructive: true,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('About', [
            _buildInfoTile('Version', '1.0.0', Icons.info),
            _buildInfoTile('Build', '100', Icons.build),
            _buildActionTile(
              'Privacy Policy',
              'Read our privacy policy',
              Icons.privacy_tip,
              _showPrivacyPolicy,
            ),
            _buildActionTile(
              'Terms of Service',
              'Read terms of service',
              Icons.description,
              _showTerms,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      secondary: Icon(icon),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildSliderTile(
    String title,
    String subtitle,
    IconData icon,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) / 2).round(),
            label: value.round().toString(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownTile(
    String title,
    String subtitle,
    IconData icon,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Theme.of(context).colorScheme.error : null,
      ),
      title: Text(
        title,
        style: isDestructive
            ? TextStyle(color: Theme.of(context).colorScheme.error)
            : null,
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildInfoTile(String title, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  void _backupData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data backed up successfully!')),
    );
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear the cache?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache cleared successfully!')),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Signed out successfully!')),
              );
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening privacy policy...')),
    );
  }

  void _showTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Opening terms of service...')),
    );
  }
}
