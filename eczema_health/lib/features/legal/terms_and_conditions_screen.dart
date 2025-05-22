import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  final VoidCallback onAccepted;
  const TermsAndConditionsScreen({Key? key, required this.onAccepted})
      : super(key: key);

  static const String termsText = '''
Terms and Conditions

By using this app, you agree to the following terms and conditions. If you do not agree to these terms, please do not use the app.

1. Use of App
This app is provided for informational and record-keeping purposes only and does not provide medical advice. Always consult a qualified healthcare provider for medical concerns.

2. User Data
You are responsible for any information you enter into the app. We do not guarantee the accuracy, completeness, or usefulness of any information provided.

3. Changes to the App
We may update, modify, or discontinue the app at any time without prior notice.

4. Limitation of Liability
We are not liable for any damages or losses resulting from your use or inability to use the app.

5. Acceptance of Terms
By using this app, you agree to these terms and any future updates to them.

''';

  static const String privacyText = '''
Privacy Policy

We respect your privacy and are committed to protecting your personal information.

1. Information Collection
We may collect personal data you provide when using the app, such as medication reminders or notes.

2. Use of Information
Your data is used solely to provide the app’s features and improve your experience. We do not sell your data to third parties.

3. Data Security
We use reasonable measures to protect your information, but cannot guarantee complete security.

4. Data Deletion
You may request deletion of your account and associated data at any time via the app.

5. Changes to this Policy
We may update this privacy policy periodically. Continued use of the app indicates your acceptance of these changes.
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Privacy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Terms and Conditions',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                  termsText + '\n\n' + privacyText,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onAccepted,
              child: const Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
