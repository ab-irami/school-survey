import 'package:school_survey/controllers/school_data/school_data_controller.dart';
import 'package:school_survey/utils/exports.dart';
import 'package:school_survey/utils/extensions/date_formatters.dart';

class SurveyCommencementView extends ConsumerStatefulWidget {
  const SurveyCommencementView({super.key});

  @override
  _SurveyCommencementViewState createState() => _SurveyCommencementViewState();
}

class _SurveyCommencementViewState
    extends ConsumerState<SurveyCommencementView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final schoolCount = ref.watch(schoolCountProvider);

    final tabs = [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard),
        selectedIcon: Icon(Icons.dashboard, color: AppColors.kGreen),

        label: Text('General'),
      ),
      for (int i = 1; i <= schoolCount; i++)
        NavigationRailDestination(
          icon: Icon(Icons.school),
          selectedIcon: Icon(Icons.school, color: AppColors.kGreen),
          label: Text('School $i'),
        ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: "Overview",
        height: 50,
        automaticallyImplyLeading: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            indicatorColor: Colors.transparent,
            onDestinationSelected: (index) {
              setState(() => selectedIndex = index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: tabs,
          ),
          Expanded(
            child: SingleChildScrollView(
              child:
                  selectedIndex == 0
                      ? GeneralInputScreen()
                      : SchoolsInputScreen(
                        schoolIndex: selectedIndex,
                        onFormValidate: (val) {
                          setState(() {
                            selectedIndex = val;
                          });
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

class SchoolsInputScreen extends ConsumerWidget {
  const SchoolsInputScreen({
    super.key,
    required this.schoolIndex,
    required this.onFormValidate,
  });

  final int schoolIndex;
  final Function(int) onFormValidate;

  bool validateAndSubmitSchools(WidgetRef ref) {
    final schoolData = ref.read(schoolDataProvider) ?? [];

    bool allValid = true;

    for (final school in schoolData) {
      if (school.name!.isEmpty ||
          school.type!.isEmpty ||
          school.curriculam!.isEmpty ||
          school.establishedAt == null ||
          school.grades!.isEmpty) {
        allValid = false;
        break;
      }
    }

    if (allValid) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKeys = ref.watch(schoolFormKeysProvider);
    GlobalKey<FormState>? formKey = formKeys[schoolIndex];
    // final schoolData = ref.read(schoolDataProvider) ?? [];

    final schoolData = ref.watch(schoolDataNotifierProvider);

    final isNewSchool = schoolIndex >= schoolData.length;

    final school = isNewSchool ? SchoolDataModel() : schoolData[schoolIndex];

    final schoolsCount = ref.read(schoolCountProvider);
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LabeledTextField(
              isRequired: true,
              label: "Name of the School",
              textfield: CustomFormField(
                keyboardType: TextInputType.text,
                hintText: "School Name",
                initialValue: school.name,
                onChanged: (val) {
                  if (val.isNotEmpty == true) {
                    ref
                        .read(schoolDataNotifierProvider.notifier)
                        .updateSchool(schoolIndex, school.copyWith(name: val));
                  }
                },
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "School name can't be empty";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            LabeledTextField(
              label: "Type of the School",
              isRequired: true,
              textfield: DropdownButtonFormField(
                hint: Text(school.type ?? ""),
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return "School type can't be empty";
                  }
                  return null;
                },
                items:
                    ["Public", "Private", "Govt Aided", "Special"].map((e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                onChanged: (val) {
                  if (val?.isNotEmpty == true) {
                    ref
                        .read(schoolDataNotifierProvider.notifier)
                        .updateSchool(schoolIndex, school.copyWith(type: val));
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            LabeledTextField(
              label: "Curriculum",
              isRequired: true,
              textfield: MultiSelectDropDown(
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "Curriculum can't be empty";
                  }
                  return null;
                },
                initialValue: school.curriculam?.join(", "),
                dropDownItems: ["CBSE", "ICSE", "IB", "State Board"],
                onSelectionChanged: (newSelectedItems) {
                  if (newSelectedItems.isNotEmpty) {
                    ref
                        .read(schoolDataNotifierProvider.notifier)
                        .updateSchool(
                          schoolIndex,
                          school.copyWith(curriculam: newSelectedItems),
                        );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            LabeledTextField(
              label: "Established Date",
              isRequired: true,
              textfield: CustomFormField(
                keyboardType: TextInputType.datetime,
                hintText: "Established On",
                readOnly: true,
                controller: TextEditingController(
                  text: ymdDateFormat(school.establishedAt),
                ),
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "Established Date can't be empty";
                  }
                  return null;
                },
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    ref
                        .read(schoolDataNotifierProvider.notifier)
                        .updateSchool(
                          schoolIndex,
                          school.copyWith(establishedAt: pickedDate),
                        );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            LabeledTextField(
              label: "Grades",
              isRequired: true,
              textfield: MultiSelectDropDown(
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "Grades can't be empty";
                  }
                  return null;
                },
                initialValue: school.grades?.join(", "),
                dropDownItems: ["Primary", "Secondary", "Higher Secondary"],
                onSelectionChanged: (newSelectedItems) {
                  if (newSelectedItems.isNotEmpty) {
                    ref
                        .read(schoolDataNotifierProvider.notifier)
                        .updateSchool(
                          schoolIndex,
                          school.copyWith(grades: newSelectedItems),
                        );
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            SubmitButton(
              onPressed: () {
                if (schoolIndex == schoolsCount) {
                  if (validateAndSubmitSchools(ref)) {
                    ref
                        .read(surveyControllerProvider.notifier)
                        .updateSurveyStatus(
                          ref.read(selectedSurveyForProgress)?.urn,
                          SurveyStatus.completed,
                        );
                    Navigator.pushReplacementNamed(context, AppRouter.HOME);
                    context.showSnack("Survey Completed Successfully!");
                  }
                } else if (formKeys[schoolIndex]?.currentState?.validate() ==
                    true) {
                  onFormValidate(schoolIndex + 1);
                }
              },
              text: schoolIndex == schoolsCount ? "Finish" : "Next",
            ),
          ],
        ),
      ),
    );
  }
}

class GeneralInputScreen extends ConsumerWidget {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> generalFormKey = GlobalKey<FormState>();

  GeneralInputScreen({super.key});

  void generateFormKeys(WidgetRef ref, int numberOfSchools) {
    final keys = <int, GlobalKey<FormState>>{};
    for (int i = 0; i < numberOfSchools; i++) {
      keys[i] = GlobalKey<FormState>();
    }
    ref.read(schoolFormKeysProvider.notifier).state = keys;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: generalFormKey,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LabeledTextField(
              label: "Name of the Area",
              isRequired: true,
              textfield: CustomFormField(
                keyboardType: TextInputType.text,
                hintText: "Area Name",
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "Area name can't be empty";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 20),
            LabeledTextField(
              label: "No.Of Schools",
              isRequired: true,
              textfield: CustomFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                hintText: "Schools count",
                validator: (p0) {
                  if (p0?.isEmpty == true) {
                    return "Schools count can't be empty";
                  } else if (int.parse(p0!) > 5) {
                    return "No.Of schools can't be greater than 5";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 25),
            SubmitButton(
              onPressed: () {
                if (generalFormKey.currentState?.validate() == true) {
                  int count = int.tryParse(controller.text) ?? 0;
                  ref.read(schoolCountProvider.notifier).state = count;
                  generateFormKeys(ref, count);
                }
              },
              width: context.width * 0.25,
              text: "Proceed",
            ),
          ],
        ),
      ),
    );
  }
}
