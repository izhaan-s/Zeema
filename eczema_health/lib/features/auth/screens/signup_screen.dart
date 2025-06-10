import 'package:eczema_health/features/auth/screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/repositories/cloud/auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();

  // Controllers for all form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  bool passwordVisible = false;
  int currentPage = 0;
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _pageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    monthController.dispose();
    dayController.dispose();
    yearController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage < 3) {
      if (_validateCurrentPage()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else {
      _submitForm();
    }
  }

  bool _validateCurrentPage() {
    switch (currentPage) {
      case 0:
        if (emailController.text.isEmpty ||
            !emailController.text.contains('@')) {
          _showError('Please enter a valid email address');
          return false;
        }
        break;
      case 1:
        if (passwordController.text.isEmpty ||
            passwordController.text.length < 6) {
          _showError('Password must be at least 6 characters');
          return false;
        }
        break;
      case 2:
        if (firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty) {
          _showError('Please enter both first and last name');
          return false;
        }
        break;
      case 3:
        if (monthController.text.isEmpty ||
            dayController.text.isEmpty ||
            yearController.text.isEmpty) {
          _showError('Please enter a valid date of birth');
          return false;
        }
        int? month = int.tryParse(monthController.text);
        int? day = int.tryParse(dayController.text);
        int? year = int.tryParse(yearController.text);
        if (month == null ||
            month < 1 ||
            month > 12 ||
            day == null ||
            day < 1 ||
            day > 31 ||
            year == null ||
            year < 1900 ||
            year > DateTime.now().year) {
          _showError('Please enter a valid date of birth');
          return false;
        }
        break;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  Future<void> _submitForm() async {
    final authRepository = AuthRepository();
    try {
      final response = await authRepository.signUpUser(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: emailController.text,
            ),
          ),
        );
      } else {
        _showError("Sign-up failed: No user returned");
      }
    } catch (e) {
      _showError("Signup failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: List.generate(4, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.only(
                        right: index < 3 ? 8 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: index <= currentPage
                            ? const Color(0xFF3b82f6)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  _buildEmailPage(),
                  _buildPasswordPage(),
                  _buildNamePage(),
                  _buildDateOfBirthPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailPage() {
    return _buildPageCard(
      title: "Create an account",
      children: [
        const SizedBox(height: 40),
        _buildLabel("Email address"),
        const SizedBox(height: 12),
        _buildTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildPasswordPage() {
    return _buildPageCard(
      title: "Create a password",
      children: [
        const SizedBox(height: 40),
        _buildLabel("Password"),
        const SizedBox(height: 12),
        _buildTextField(
          controller: passwordController,
          obscureText: !passwordVisible,
          textInputAction: TextInputAction.next,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                passwordVisible = !passwordVisible;
              });
            },
            icon: Icon(
              passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF3b82f6),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNamePage() {
    return _buildPageCard(
      title: "Enter your name",
      children: [
        const SizedBox(height: 40),
        _buildLabel("First name"),
        const SizedBox(height: 12),
        _buildTextField(
          controller: firstNameController,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 24),
        _buildLabel("Last name"),
        const SizedBox(height: 12),
        _buildTextField(
          controller: lastNameController,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }

  Widget _buildDateOfBirthPage() {
    return _buildPageCard(
      title: "What's your date of birth?",
      children: [
        const SizedBox(height: 40),
        _buildLabel("Date of birth"),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                controller: monthController,
                hintText: "MM",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 2,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 1,
              child: _buildTextField(
                controller: dayController,
                hintText: "DD",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 2,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: yearController,
                hintText: "YYYY",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                maxLength: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageCard({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1a365d),
                ),
              ),
              ...children,
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b82f6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentPage == 3 ? "Create Account" : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1a365d),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    bool obscureText = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Widget? suffixIcon,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLength: maxLength,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        counterText: "", // Hide character counter
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF3b82f6),
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF3b82f6),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF3b82f6),
            width: 2,
          ),
        ),
      ),
    );
  }
}
