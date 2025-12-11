import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLogin = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppAuthProvider>().clearErrors();
    });
  }

  void _showFirebaseError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AppAuthProvider>();

    if (auth.firebaseError != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showFirebaseError(context, auth.firebaseError!);
        auth.firebaseError = null;
      });
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLogin ? "Вхід" : "Реєстрація",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 25),

            // ---------------- Email ----------------
            TextField(
              controller: emailCtrl,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                errorText: auth.emailError,
              ),
              onChanged: (_) => auth.validateEmail(emailCtrl.text),
            ),
            const SizedBox(height: 18),

            // ---------------- Password ----------------
            TextField(
              controller: passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Пароль",
                prefixIcon: const Icon(Icons.lock_outline),
                errorText: auth.passwordError,
              ),
              onChanged: (_) => auth.validatePassword(passCtrl.text),
            ),
            const SizedBox(height: 28),

            // ---------------- Button ----------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isLogin) {
                    await auth.login(emailCtrl.text, passCtrl.text);
                  } else {
                    await auth.register(emailCtrl.text, passCtrl.text);
                  }
                },
                child: Text(isLogin ? "Увійти" : "Створити акаунт"),
              ),
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                context.read<AppAuthProvider>().clearErrors();
                setState(() => isLogin = !isLogin);
              },
              child: Text(isLogin ? "Створити акаунт" : "Вже маєте акаунт? Увійти"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }
}
