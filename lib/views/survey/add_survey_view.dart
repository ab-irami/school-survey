import 'package:school_survey/utils/exports.dart';
import 'package:school_survey/utils/extensions/date_formatters.dart';

class AddSurveyView extends ConsumerStatefulWidget {
  const AddSurveyView({super.key});

  @override
  ConsumerState<AddSurveyView> createState() => _AddSurveyViewState();
}

class _AddSurveyViewState extends ConsumerState<AddSurveyView> {
  final GlobalKey<FormState> addSurveyForm = GlobalKey<FormState>();

  late TextEditingController surveyNameController;
  late TextEditingController descriptionController;
  late TextEditingController assignedToController;
  late TextEditingController commencementDateController;
  late TextEditingController dueDateController;

  @override
  void initState() {
    super.initState();

    final currentSurvey = ref.read(selectedSurveyForProgress);
    final isEditingSurvey = ref.read(isEditingSurveyProvider);

    surveyNameController = TextEditingController(
      text: isEditingSurvey ? currentSurvey?.name : "",
    );
    descriptionController = TextEditingController(
      text: isEditingSurvey ? currentSurvey?.description : "",
    );
    assignedToController = TextEditingController(
      text: isEditingSurvey ? currentSurvey?.assignedTo : "",
    );
    commencementDateController = TextEditingController(
      text:
          isEditingSurvey
              ? ymdDateFormat(currentSurvey?.commencementDate)
              : ymdDateFormat(ref.read(commencementDatePickerProvider)),
    );
    dueDateController = TextEditingController(
      text:
          isEditingSurvey
              ? ymdDateFormat(currentSurvey?.dueDate)
              : ymdDateFormat(ref.read(dueDatePickerProvider)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveyController = ref.watch(surveyControllerProvider);

    final currentSurvey = ref.watch(selectedSurveyForProgress);

    final bool isEditingSurvey = ref.watch(isEditingSurveyProvider);

    ref.listen(commencementDatePickerProvider, (_, next) {
      commencementDateController.text = ymdDateFormat(next);
    });
    ref.listen(dueDatePickerProvider, (_, next) {
      dueDateController.text = ymdDateFormat(next);
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: "${isEditingSurvey == true ? "Edit " : "Add"} Survey",
        automaticallyImplyLeading: true,
        height: 50,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(context.width * 0.04),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: addSurveyForm,
                child: Column(
                  children: [
                    LabeledTextField(
                      label: "Name",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.text,
                        hintText: "Name of the Survey",
                        controller: surveyNameController,
                        onChanged: (value) {
                          ref.read(surveyNameProvider.notifier).state = value;
                        },
                        validator: (p0) {
                          if (p0?.isEmpty == true) {
                            return "Name can't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Reference Number",
                      isRequired: true,
                      textfield: CustomFormField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        hintText: "Unique Ref Number",
                        initialValue:
                            isEditingSurvey == true
                                ? currentSurvey?.urn
                                : ref.read(urnStateProvider).toString(),
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Description",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.text,
                        hintText: "Detailed Description",
                        controller: descriptionController,
                        onChanged: (value) {
                          ref.read(descriptionProvider.notifier).state = value;
                        },
                        validator: (p0) {
                          if (p0?.isEmpty == true) {
                            return "Description can't be empty";
                          } else if (p0!.length < 80) {
                            return "Description need to be atleast 80 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Commencement Date",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.datetime,
                        readOnly: true,
                        hintText: "Date of Commencement",
                        controller: commencementDateController,
                        validator: (p0) {
                          if (p0?.isEmpty == true) {
                            return "Commencement Date can't be empty";
                          }
                          return null;
                        },
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2028),
                          );

                          if (pickedDate != null) {
                            ref
                                .watch(commencementDatePickerProvider.notifier)
                                .state = pickedDate;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Due Date",
                      isRequired: true,
                      textfield: CustomFormField(
                        readOnly: true,
                        hintText: 'Due Date',
                        keyboardType: TextInputType.text,
                        controller: dueDateController,
                        validator: (p0) {
                          if (p0?.isEmpty == true) {
                            return "Due Date can't be empty";
                          }
                          return null;
                        },

                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2028),
                          );

                          if (pickedDate != null) {
                            ref.watch(dueDatePickerProvider.notifier).state =
                                pickedDate;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Assigned To",
                      isRequired: true,
                      textfield: CustomFormField(
                        keyboardType: TextInputType.text,
                        controller: assignedToController,
                        onChanged: (value) {
                          ref.read(assignedToProvider.notifier).state = value;
                        },
                        hintText: "Assigned To",
                        validator: (p0) {
                          if (p0?.isEmpty == true) {
                            return "Assignee must be there";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: context.height * 0.02),
                    LabeledTextField(
                      label: "Assigned By",
                      isRequired: true,
                      textfield: CustomFormField(
                        initialValue: ref.read(userProvider)?.email,
                        enabled: false,
                        keyboardType: TextInputType.text,
                        hintText: "Assigned By",
                      ),
                    ),
                    SizedBox(height: context.height * 0.04),
                    surveyController.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : SubmitButton(
                          onPressed: () {
                            if (addSurveyForm.currentState?.validate() ==
                                true) {
                              if (isEditingSurvey == true) {}
                              SurveyModel surveyModel = SurveyModel(
                                name: ref.read(surveyNameProvider),
                                urn:
                                    isEditingSurvey == true
                                        ? currentSurvey?.urn
                                        : ref.read(urnStateProvider).toString(),
                                description: ref.read(descriptionProvider),
                                commencementDate: ref.read(
                                  commencementDatePickerProvider,
                                ),
                                dueDate: ref.read(dueDatePickerProvider),
                                assignedBy: ref.read(userProvider)?.email,
                                assignedTo: ref.read(assignedToProvider),
                                status: SurveyStatus.scheduled,
                              );
                              if (isEditingSurvey == true) {
                                ref
                                    .read(surveyControllerProvider.notifier)
                                    .updateSurvey(
                                      currentSurvey?.urn,
                                      surveyModel,
                                    )
                                    .then((val) {
                                      addSurveyForm.currentState?.reset();
                                      context.showSnack(
                                        "Survey updated Successfully!",
                                      );
                                      ref
                                          .watch(
                                            isEditingSurveyProvider.notifier,
                                          )
                                          .state = false;
                                      Navigator.of(context).pop();
                                    })
                                    .onError((e, s) {
                                      context.showSnack("Something Went Wrong");
                                    });
                              } else {
                                ref
                                    .read(surveyControllerProvider.notifier)
                                    .addSurvey(surveyModel)
                                    .then((val) {
                                      addSurveyForm.currentState?.reset();
                                      context.showSnack(
                                        "Survey added Successfully!",
                                      );
                                      Navigator.of(context).pop();
                                    })
                                    .onError((e, s) {
                                      context.showSnack("Something Went Wrong");
                                    });
                              }
                            }
                          },
                          text: "Submit",
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
