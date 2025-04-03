import 'package:school_survey/utils/exports.dart';
import 'package:school_survey/utils/extensions/date_formatters.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final surveyController = ref.watch(surveyControllerProvider);

    final scheduledSurveys = ref.watch(scheduledSurveysProvider);
    final completedSurveys = ref.watch(completedSurveysProvider);
    final withheldSurveys = ref.watch(withheldSurveysProvider);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(
          title: ref.read(userProvider)?.email?.substring(0, 6) ?? "User",
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: TabBar(
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              dividerHeight: 0,
              tabs: [
                Tab(text: "Scheduled"),
                Tab(text: "Completed"),
                Tab(text: "With-Held"),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            scheduledSurveys == null
                ? Center(child: CircularProgressIndicator())
                : buildListView(
                  context,
                  surveys: scheduledSurveys,
                  widgetRef: ref,
                ),
            completedSurveys == null
                ? Center(child: CircularProgressIndicator())
                : buildListView(
                  context,
                  surveys: completedSurveys,
                  widgetRef: ref,
                ),
            withheldSurveys == null
                ? Center(child: CircularProgressIndicator())
                : buildListView(
                  context,
                  surveys: withheldSurveys,
                  widgetRef: ref,
                ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.watch(selectedSurveyForProgress.notifier).state = null;
            ref.watch(isEditingSurveyProvider.notifier).state = false;
            Navigator.of(context).pushNamed(AppRouter.ADDSURVEY);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  buildTableRow(
    BuildContext context, {
    required String rowHead,
    required String? rowData,
  }) {
    return [
      TableRow(
        children: [
          Text(
            rowHead,
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.kLightGrey3,
            ),
          ),
          Text("$rowData"),
        ],
      ),
      TableRow(children: [SizedBox(height: 10), SizedBox(height: 10)]),
    ];
  }

  buildListView(
    BuildContext context, {
    required List<SurveyModel> surveys,
    required WidgetRef widgetRef,
  }) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.04,
        vertical: context.width * 0.04,
      ),
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: ExpansionTile(
            tilePadding: EdgeInsets.only(left: 8, right: 5),
            backgroundColor: AppColors.kWhite,
            expandedCrossAxisAlignment: CrossAxisAlignment.center,
            expandedAlignment: Alignment.center,
            subtitle: Text(
              "Ref.No:  ${surveys[index].urn}",
              style: context.bodySmall,
            ),
            shape: Border(),
            collapsedShape: Border(),
            title: Text(
              "${surveys[index].name}",
              style: context.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    widgetRef.read(selectedSurveyForProgress.notifier).state =
                        surveys[index];
                    Navigator.of(
                      context,
                    ).pushNamed(AppRouter.SURVEYCOMMENCEMENT);
                  },
                  child: Icon(
                    Icons.play_arrow_outlined,
                    size: 22,
                    color: AppColors.kLightGrey3,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    widgetRef.read(selectedSurveyForProgress.notifier).state =
                        surveys[index];
                    widgetRef.read(isEditingSurveyProvider.notifier).state =
                        true;
                    Navigator.of(context).pushNamed(AppRouter.ADDSURVEY);
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    size: 22,
                    color: AppColors.kLightGrey3,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    widgetRef
                        .read(surveyControllerProvider.notifier)
                        .updateSurveyStatus(
                          surveys[index].urn,
                          SurveyStatus.withheld,
                        );
                  },
                  child: Icon(
                    Icons.delete_outline_outlined,
                    size: 22,
                    color: AppColors.kLightGrey3,
                  ),
                ),
              ],
            ),
            childrenPadding: EdgeInsets.symmetric(
              horizontal: context.width * 0.04,
              vertical: 8,
            ),
            children: [
              Table(
                columnWidths: {0: FlexColumnWidth(1.5), 1: FlexColumnWidth(3)},
                children: [
                  ...buildTableRow(
                    context,
                    rowHead: "Description",
                    rowData: surveys[index].description,
                  ),
                  ...buildTableRow(
                    context,
                    rowHead: "Com. Date",
                    rowData: ymdDateFormat(surveys[index].commencementDate),
                  ),
                  ...buildTableRow(
                    context,
                    rowHead: "Due Date",
                    rowData: ymdDateFormat(surveys[index].dueDate),
                  ),
                  ...buildTableRow(
                    context,
                    rowHead: "Assigned To",
                    rowData: surveys[index].assignedTo,
                  ),
                  ...buildTableRow(
                    context,
                    rowHead: "Assigned By",
                    rowData: surveys[index].assignedBy,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: surveys.length,
    );
  }
}
