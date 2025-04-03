import 'package:school_survey/utils/exports.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final GlobalKey<FormState> signUpForm = GlobalKey<FormState>();

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: context.keyBoardVisibility == false ? AppBar(elevation: 0) : null,
      body: CustomScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        physics: const ScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  context.keyBoardVisibility == false
                      ? EdgeInsets.all(context.width * 0.04)
                      : EdgeInsets.symmetric(horizontal: context.width * 0.04),
              child: Form(
                key: signUpForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: context.height * 0.2,
                        child: Image.asset(
                          Assets.images.signupPNG,
                          width: context.width * 0.8,
                        ),
                      ),
                    ),
                    SizedBox(height: context.height * 0.01),
                    Text(
                      'Sign Up',
                      style: context.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: context.width * 0.08,
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Email",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (p0) {
                          ref.watch(userProvider.notifier).state = UserModel(
                            email: p0,
                          );
                        },
                        hintText: "qwerty@gmail.com",
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Email can't be empty";
                          } else if (value?.isValidEmail() == false) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Password",
                      isRequired: true,
                      textfield: CustomFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: "******a",
                        obscuringText: true,
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Password can't be empty";
                          } else if (value?.isValidPassword() == false) {
                            return validatePassword(value!);
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Confirm Password",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscuringText: true,
                        hintText: "******a",
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return "Password can't be empty";
                          } else if (value != passwordController.text) {
                            return "Password doesn't match";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.05),
                    SubmitButton(
                      onPressed: () {
                        if (signUpForm.currentState?.validate() == true) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.HOME,
                            (route) => false,
                          );
                        }
                      },
                      text: 'Sign Up',
                    ),
                    SizedBox(height: context.height * 0.05),
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "OR",
                          style: context.bodySmall?.copyWith(
                            color: AppColors.kGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: context.height * 0.03),
                    Align(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an Account? ",
                          style: context.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: context.bodyMedium?.copyWith(
                                color: AppColors.kGreen,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
