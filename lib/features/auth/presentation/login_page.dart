
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../injection_container.dart';
import '../../products/presentation/pages.dart';
import 'bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginBloc>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
    String? errorText,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
      errorText: errorText,
      prefixIcon: Icon(
        icon,
        color: AppColors.forestGreen,
      ),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: AppColors.card,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.inputBorder,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.inputBorder,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.forestGreen,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ProductsPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        final formState = state is LoginFormState
            ? state
            : const LoginFormState();

        return Scaffold(
          backgroundColor: AppColors.cream,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 420,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Brand panel
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 26,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.forestGreen,
                              AppColors.deepGreen,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.forestGreen.withValues(
                                alpha: 0.16,
                              ),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.checkroom_outlined,
                              size: 58,
                              color: AppColors.cream,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'STYLE STORE',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.brandTitle,
                            ),
                            const SizedBox(height: 7),
                            const Text(
                              'FASHION FOR EVERY YOU',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.brandTagline,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        'Welcome back',
                        style: AppTextStyles.pageTitle,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Sign in to discover your style.',
                        style: AppTextStyles.body,
                      ),

                      const SizedBox(height: 28),

                      // Email field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(
                            LoginEmailChanged(value),
                          );
                        },
                        decoration: _inputDecoration(
                          label: 'Email address',
                          hintText: 'demo@stylestore.com',
                          icon: Icons.email_outlined,
                          errorText: formState.email.isEmpty ||
                              formState.isEmailValid
                              ? null
                              : 'Enter a valid email address',
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Password field
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          context.read<LoginBloc>().add(
                            LoginPasswordChanged(value),
                          );
                        },
                        decoration: _inputDecoration(
                          label: 'Password',
                          icon: Icons.lock_outline,
                          errorText: formState.password.isEmpty ||
                              formState.isPasswordValid
                              ? null
                              : 'Password is required',
                          suffixIcon: IconButton(
                            tooltip: _obscurePassword
                                ? 'Show password'
                                : 'Hide password',
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),

                      // Login error
                      if (formState.errorMessage != null) ...[
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  formState.errorMessage!,
                                  style: AppTextStyles.errorMessage,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Sign-in button

                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.forestGreen,
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: AppColors.forestGreen.withOpacity(0.45),
                            disabledForegroundColor: Colors.white70,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: formState.canSubmit
                              ? () {
                            context.read<LoginBloc>().add(
                              const LoginSubmitted(),
                            );
                          }
                              : null,
                          child: formState.isSubmitting
                              ? const SizedBox(
                            height: 23,
                            width: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            'SIGN IN',
                            style: AppTextStyles.button,
                          ),
                        ),
                      ),


                      const SizedBox(height: 24),


                      const SizedBox(height: 70),

                      Text(
                        'Your style, your story.',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.footer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
