import 'package:eczema_health/features/auth/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/cloud/auth_repository.dart';

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
  DateTime? selectedDate;
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

  void _previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
        if (selectedDate == null) {
          _showError('Please select a valid date of birth');
          return false;
        }
        break;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.warning_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Oops!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color(0xFFDC2626),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 4),
        elevation: 6,
      ),
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        resizeToAvoidBottomInset: true,
        appBar: currentPage > 0
            ? AppBar(
                backgroundColor: const Color(0xFFF8FAFC),
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Color(0xFF3b82f6)),
                  onPressed: _previousPage,
                ),
                title: Text(
                  "Step ${currentPage + 1} of 4",
                  style: const TextStyle(
                    color: Color(0xFF64748b),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
              )
            : null,
        body: SafeArea(
          child: Column(
            children: [
              // Enhanced Progress indicator
              Container(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create Account",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1a365d),
                                  ),
                        ),
                        Text(
                          "${currentPage + 1}/4",
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xFF64748b),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: List.generate(4, (index) {
                        final isCompleted = index < currentPage;
                        final isCurrent = index == currentPage;

                        return Expanded(
                          child: Container(
                            height: 6,
                            margin: EdgeInsets.only(
                              right: index < 3 ? 8 : 0,
                            ),
                            decoration: BoxDecoration(
                              color: isCompleted || isCurrent
                                  ? const Color(0xFF3b82f6)
                                  : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: isCompleted || isCurrent
                                    ? const Color(0xFF3b82f6)
                                    : const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              // Page content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics:
                      const BouncingScrollPhysics(), // Allow swipe navigation for back/forward
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
      ),
    );
  }

  Widget _buildEmailPage() {
    return _buildPageCard(
      title: "Create an account",
      children: [
        _buildLabel("Email address"),
        const SizedBox(height: 16),
        _buildTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          hintText: "your.email@example.com",
          semanticLabel: "Email address input field",
        ),
        const SizedBox(height: 12),
        Text(
          "We'll use this to send you important updates about your account.",
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF64748b).withOpacity(0.8),
            height: 1.4,
          ),
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
        _buildLabel("Date of birth"),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: _showDatePicker,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              border: Border.all(
                color: selectedDate != null
                    ? const Color(0xFF3b82f6)
                    : const Color(0xFFE2E8F0),
                width: selectedDate != null ? 2.5 : 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: selectedDate != null
                      ? const Color(0xFF3b82f6)
                      : const Color(0xFF64748b),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                        : "Select your date of birth",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedDate != null
                          ? const Color(0xFF1a365d)
                          : const Color(0xFF64748b).withOpacity(0.6),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: selectedDate != null
                      ? const Color(0xFF3b82f6)
                      : const Color(0xFF64748b),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "This helps us provide age-appropriate health recommendations.",
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF64748b).withOpacity(0.8),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  void _showDatePicker() {
    final DateTime now = DateTime.now();
    final DateTime initialDate =
        selectedDate ?? DateTime(now.year - 25, now.month, now.day);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xFF64748b),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1a365d),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                          color: Color(0xFF3b82f6),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Date Picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: initialDate,
                  minimumDate: DateTime(1900),
                  maximumDate: now,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      selectedDate = newDate;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPageCard({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with better typography
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1a365d),
                          height: 1.2,
                          letterSpacing: -0.5,
                        ) ??
                    const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1a365d),
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: 8),
              // Subtitle for context
              Text(
                "Step ${currentPage + 1} of 4",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF64748b),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ) ??
                    const TextStyle(
                      color: Color(0xFF64748b),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 48),
              ...children,
              const Spacer(),
              // Button with improved styling
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3b82f6),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    currentPage == 3 ? "Create Account" : "Next",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1a365d),
          letterSpacing: 0.1,
        ),
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
    String? semanticLabel,
  }) {
    return Semantics(
      label: semanticLabel,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLength: maxLength,
        cursorColor: const Color(0xFF3b82f6),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF1a365d),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: const Color(0xFF64748b).withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          counterText: "", // Hide character counter
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFE2E8F0),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFF3b82f6),
              width: 2.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFDC2626),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: Color(0xFFDC2626),
              width: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}
