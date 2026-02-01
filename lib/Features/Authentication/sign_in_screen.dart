import 'package:flutter/material.dart' as material;
import 'package:hello_flutter/Theme/app_colors.dart';
import 'package:hello_flutter/Theme/app_text_styles.dart';
import 'package:hello_flutter/Utils/spacing.dart';
import 'package:hello_flutter/components/button/button.dart';
import 'package:hello_flutter/components/divider/divider.dart';
import 'package:hello_flutter/components/icon/icon.dart';
import 'package:hello_flutter/components/icon-button/icon_button.dart';
import 'package:hello_flutter/components/text-field/text_field.dart';
import 'package:hello_flutter/components/text/text.dart' as app_text;

/// Sign In screen matching the design:
/// Header with back arrow, title, subtitle; card form with email/password,
/// forgot password, primary button; footer with sign up and social login.
class SignInScreen extends material.StatefulWidget {
  const SignInScreen({super.key});

  @override
  material.State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends material.State<SignInScreen> {
  final _formKey = material.GlobalKey<material.FormState>();
  final _emailController = material.TextEditingController();
  final _passwordController = material.TextEditingController();

  String? _emailError;
  String? _passwordError;
  bool _obscurePassword = true;
  bool _isLoading = false;

  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateAndSubmit() {
    setState(() {
      _emailError = _validateEmail(_emailController.text);
      _passwordError = _validatePassword(_passwordController.text);
    });
    if (_emailError != null || _passwordError != null) return;

    _isLoading = true;
    setState(() {});
    // TODO: Connect to authentication logic (e.g. API call).
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isLoading = false);
        material.Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  String? _validateEmail(String value) {
    if (value.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _onForgotPassword() {
    // TODO: Navigate to forgot password flow.
  }

  void _onSignUp() {
    material.Navigator.of(context).push(
      material.MaterialPageRoute(
        builder: (context) => const _SignUpPlaceholder(),
      ),
    );
  }

  void _onSocialLogin(String provider) {
    // TODO: Connect social login (Google, Apple, Facebook).
  }

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      backgroundColor: AppColors.primary,
      body: material.SafeArea(
        child: material.Column(
          children: [
            _buildHeader(context),
            material.Expanded(
              child: material.SingleChildScrollView(
                padding: const material.EdgeInsets.only(top: Spacing.lg),
                child: _buildFormCard(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  material.Widget _buildHeader(material.BuildContext context) {
    return material.Padding(
      padding: const material.EdgeInsets.fromLTRB(
        Spacing.md,
        Spacing.sm,
        Spacing.md,
        Spacing.lg,
      ),
      child: material.Column(
        crossAxisAlignment: material.CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: material.Icons.chevron_left,
            onPressed: () => material.Navigator.of(context).maybePop(),
            color: AppColors.surface,
            size: 28,
          ),
          const material.SizedBox(height: Spacing.sm),
          app_text.Text('Hello, Sign in!', style: AppTextStyles.headingLarge),
          const material.SizedBox(height: Spacing.xs),
          app_text.Text(
            'Access your health records securely.',
            style: AppTextStyles.subtitle,
          ),
        ],
      ),
    );
  }

  material.Widget _buildFormCard(material.BuildContext context) {
    return material.Container(
      width: double.infinity,
      decoration: const material.BoxDecoration(
        color: AppColors.surface,
        borderRadius: material.BorderRadius.only(
          topLeft: material.Radius.circular(24),
          topRight: material.Radius.circular(24),
        ),
      ),
      child: material.Form(
        key: _formKey,
        child: material.Padding(
          padding: const material.EdgeInsets.fromLTRB(
            Spacing.lg,
            Spacing.xl,
            Spacing.lg,
            Spacing.xxl,
          ),
          child: material.Column(
            crossAxisAlignment: material.CrossAxisAlignment.stretch,
            children: [
              app_text.Text('EMAIL', style: AppTextStyles.label),
              const material.SizedBox(height: Spacing.sm),
              TextField(
                controller: _emailController,
                hint: 'hello@example.com',
                keyboardType: material.TextInputType.emailAddress,
                errorText: _emailError,
                onChanged: (_) => setState(() => _emailError = null),
                suffixIcon: material.Padding(
                  padding: const material.EdgeInsets.only(right: 12),
                  child: Icon(
                    iconData: material.Icons.email_outlined,
                    size: 20,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
              const material.SizedBox(height: Spacing.lg),
              app_text.Text('PASSWORD', style: AppTextStyles.label),
              const material.SizedBox(height: Spacing.sm),
              TextField(
                controller: _passwordController,
                hint: '••••••••',
                obscureText: _obscurePassword,
                errorText: _passwordError,
                onChanged: (_) => setState(() => _passwordError = null),
                suffixIcon: material.Padding(
                  padding: const material.EdgeInsets.only(right: 12),
                  child: material.GestureDetector(
                    onTap: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                    child: Icon(
                      iconData: _obscurePassword
                          ? material.Icons.visibility_off_outlined
                          : material.Icons.visibility_outlined,
                      size: 20,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              ),
              const material.SizedBox(height: Spacing.sm),
              material.Align(
                alignment: material.Alignment.centerRight,
                child: material.TextButton(
                  onPressed: _onForgotPassword,
                  style: material.TextButton.styleFrom(
                    foregroundColor: AppColors.link,
                    padding: const material.EdgeInsets.symmetric(horizontal: 0),
                  ),
                  child: app_text.Text(
                    'Forgot password?',
                    style: AppTextStyles.link,
                  ),
                ),
              ),
              const material.SizedBox(height: Spacing.lg),
              Button(
                label: 'SIGN IN',
                type: ButtonType.primary,
                size: ButtonSize.large,
                color: AppColors.primary,
                isLoading: _isLoading,
                onPressed: _validateAndSubmit,
              ),
              const material.SizedBox(height: Spacing.xl),
              material.Row(
                mainAxisAlignment: material.MainAxisAlignment.center,
                children: [
                  app_text.Text(
                    'Don\'t have an account? ',
                    style: AppTextStyles.bodySecondary,
                  ),
                  material.GestureDetector(
                    onTap: _onSignUp,
                    child: app_text.Text('Sign up', style: AppTextStyles.link),
                  ),
                ],
              ),
              const material.SizedBox(height: Spacing.xl),
              _buildDividerWithLabel(),
              const material.SizedBox(height: Spacing.lg),
              _buildSocialButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  material.Widget _buildDividerWithLabel() {
    return material.Row(
      children: [
        material.Expanded(
          child: Divider(color: AppColors.border, thickness: 1),
        ),
        material.Padding(
          padding: const material.EdgeInsets.symmetric(horizontal: Spacing.md),
          child: app_text.Text(
            'LOGIN WITH SOCIAL MEDIA',
            style: AppTextStyles.dividerLabel,
          ),
        ),
        material.Expanded(
          child: Divider(color: AppColors.border, thickness: 1),
        ),
      ],
    );
  }

  material.Widget _buildSocialButtons(material.BuildContext context) {
    return material.Row(
      mainAxisAlignment: material.MainAxisAlignment.center,
      children: [
        _SocialButton(
          onTap: () => _onSocialLogin('google'),
          child: Icon(
            iconData: material.Icons.g_mobiledata,
            size: 28,
            color: AppColors.textPrimary,
          ),
        ),
        const material.SizedBox(width: Spacing.lg),
        _SocialButton(
          onTap: () => _onSocialLogin('apple'),
          child: Icon(
            iconData: material.Icons.apple,
            size: 28,
            color: AppColors.textPrimary,
          ),
        ),
        const material.SizedBox(width: Spacing.lg),
        _SocialButton(
          onTap: () => _onSocialLogin('facebook'),
          child: Icon(
            iconData: material.Icons.facebook,
            size: 28,
            color: const material.Color(0xFF1877F2),
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends material.StatelessWidget {
  final material.VoidCallback onTap;
  final material.Widget child;

  const _SocialButton({required this.onTap, required this.child});

  @override
  material.Widget build(material.BuildContext context) {
    return material.Material(
      color: AppColors.surface,
      shape: const material.CircleBorder(),
      child: material.InkWell(
        onTap: onTap,
        customBorder: const material.CircleBorder(),
        child: material.Container(
          width: 56,
          height: 56,
          decoration: material.BoxDecoration(
            shape: material.BoxShape.circle,
            border: material.Border.all(color: AppColors.border),
          ),
          alignment: material.Alignment.center,
          child: child,
        ),
      ),
    );
  }
}

class _SignUpPlaceholder extends material.StatelessWidget {
  const _SignUpPlaceholder();

  @override
  material.Widget build(material.BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(title: const material.Text('Sign up')),
      body: const material.Center(
        child: material.Text(
          'Sign up screen – connect to signup_screen when ready',
        ),
      ),
    );
  }
}
