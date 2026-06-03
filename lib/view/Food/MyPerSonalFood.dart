import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CommonLoadingSCreen.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/Food/AddDishUsingMyPersonalDish.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//personal food list page
class PersonalInfoPage extends StatefulWidget {
  final String dishType;
  final String dishTypeSendForBackened;

  const PersonalInfoPage({super.key, 
    required this.dishType,
    required this.dishTypeSendForBackened,
  });
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  List<Map<String, dynamic>> personalInfoList = [];
  List<Map<String, dynamic>> filteredList = [];
  bool isLoadingScreenCheck = true;

  @override
  void initState() {
    super.initState();
    // Fetch personal info data when the page is initialized
    fetchPersonalInfo();
  }

  final UserProfileController _controller = UserProfileController();
  Future<void> fetchPersonalInfo() async {
    // setState(() {
    //   isLoadingScreenCheck = true;
    // });
    // Call the API function to get personal info data
    List<Map<String, dynamic>> data = await _controller.getPersonalInfo();

    // Update the state with the fetched data
    setState(() {
      isLoadingScreenCheck = false;
      personalInfoList = data;
      filteredList = List.from(personalInfoList.reversed.toList());
    });
  }

  void filterList(String query) {
    // Filter the list based on the search query
    setState(() {
      filteredList = personalInfoList
          .where((item) =>
              item['itemname'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void navigateToDetailsPage(int perRecId, String RecipeName) {
    // Navigate to the details page and pass perRecId
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddDishUsingMyPersonalDish(
            // RecipeId: perRecId,
            RecipeName: RecipeName,
            dishTypeSendForBackened: widget.dishTypeSendForBackened,
            dishType: widget.dishType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeManager.themeColor,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ThemeManager.themelightColor,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              color: ThemeManager.themeText,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          Languages.of(context)!.ninTextMyPersonalRecipe,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: isLoadingScreenCheck
          ? const CommonDataLoadingScreen()
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 64,
                    decoration: ShapeDecoration(
                      color: ThemeManager.themelightColor.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1, color: ThemeManager.themelightColor),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TextField(
                        onChanged: (value) => filterList(value),
                        decoration: InputDecoration(
                          labelText:
                              Languages.of(context)!.ninTextSearchByRecipeName,
                          labelStyle: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                          hintStyle: TextStyle(
                            color: ThemeManager.themeText,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: ThemeManager.themeText,
                        ),
                      ),
                    ),
                  ),
                ),
                if (filteredList.isEmpty)
                  Column(
                    children: [
                      sizedBox30(),
                      sizedBox30(),
                      Center(child: Text(Languages.of(context)!.NINTextNoData)),
                    ],
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: TColor.primaryColor1.withOpacity(0.3)),
                            color: ThemeManager.themelightColor),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: ListTile(
                          leading: Image.asset(
                            "assets/img/foodimage.png",
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          title: Row(
                            children: [
                              SizedBox(
                                width: media.width * 0.4,
                                child: Text(
                                  filteredList[index]['itemname'],
                                  style:
                                      TextStyle(color: ThemeManager.themeText),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // title: Text('Delete Food'),
                                        content: Text(Languages.of(context)!
                                            .confirmDelete),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                            },
                                            child: Text(
                                                Languages.of(context)!.cancel),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              // Perform delete operation here
                                              debugPrint('Food deleted!');
                                              await _controller
                                                  .deleteDishPersonal(
                                                      filteredList[index]
                                                          ['perRecId']);
                                              debugPrint('Food deleted!');
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                              fetchPersonalInfo();
                                            },
                                            child: Text(Languages.of(context)!
                                                .ninTextDelete),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            int perRecId = filteredList[index]['perRecId'];
                            navigateToDetailsPage(
                                perRecId, filteredList[index]['itemname']);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
