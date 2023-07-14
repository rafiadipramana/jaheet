import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/theme.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up-screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Buat akun baru',
              style: secondaryTextStyle.copyWith(
                fontSize: 28,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Masukkan informasi Anda pada form di bawah ini untuk dapat menggunakan aplikasi Jaheet',
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget namaInput() {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              style: subtitleTextStyle,
              keyboardType: TextInputType.name,
              decoration: InputDecoration.collapsed(
                hintText: 'Nama Lengkap',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              controller: emailController,
              style: subtitleTextStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration.collapsed(
                hintText: 'E-mail',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              controller: passwordController,
              style: subtitleTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Password',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget passwordConfirmationInput() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor4,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: TextFormField(
              controller: passwordConfirmController,
              style: subtitleTextStyle,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Konfirmasi Password',
                hintStyle: subtitleTextStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget rememberMe() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                //
              },
              icon: Icon(
                Icons.check_box_rounded,
                size: 24,
                color: primaryColor,
              ),
            ),
            Text(
              'Ingat saya',
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return TextButton(
        onPressed: () {},
        child: Text(
          'Lupa Password?',
          style: navyTextStyle.copyWith(
            fontSize: 16,
            color: primaryColor,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    Widget buttonSignUp() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            try {
              final email = emailController.text;
              final password = passwordController.text;

              await auth.createUserWithEmailAndPassword(
                  email: email, password: password);
              Navigator.pop(context);
            } catch (e) {
              final snackBar = SnackBar(
                content: Text(e.toString()),
                backgroundColor: alertColor,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } finally {
              setState(() {
                isLoading = false;
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Daftar',
            style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
        ),
      );
    }

    Widget textLogin() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sudah punya akun?',
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SignInScreen.routeName);
              },
              child: Text(
                'Masuk',
                style: navyTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget buttonLoginGoogle() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        height: 50,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor4,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/google.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Masuk dengan Google',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor1,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    header(),
                    namaInput(),
                    emailInput(),
                    passwordInput(),
                    passwordConfirmationInput(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        rememberMe(),
                        forgotPassword(),
                      ],
                    ),
                    buttonSignUp(),
                    textLogin(),
                    buttonLoginGoogle(),
                    SizedBox(
                      height: defaultMargin,
                    )
                  ],
                ),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
