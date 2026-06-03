import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/view/HealthTrends/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

class MainPdfView extends StatefulWidget {
  const MainPdfView({super.key});

  @override
  State<MainPdfView> createState() => _MainPdfViewState();
}

class _MainPdfViewState extends State<MainPdfView> {
  // Function to open the URL in Chrome
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
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
              color: ThemeManager.themeText,
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "PDFs",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            sizedBox30(),
            ContainerWidget(
              text: 'ABCD Chart latest',
              icon: Icons.arrow_forward,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => PDFScreen2(
                //             lablename: "ABCD Chart latest",
                //             pdfAssetPath:
                //                 "assets/img/pdfs/ABCD Chart latest.pdf",
                //           )),
                // );
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Adolescence',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Adolescent_Growth_Spurt',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Anaemia_and_folates',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Anaemia1',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Baby_care_study_for_Growth_&_Development',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Calcium',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Dietary_Guidelines_for_Indians (HINDI) booklet - A4',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Family_life_education_for_Adolescent_girls',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Five_Keys_for_Household_Food    _Safety',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Flipchart-II',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Flipchart-III',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Flipchart-IV',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Functions_of_foods',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Infant_feeding',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Low_cost_nut_recipes',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Mazy_Dazy_Game_on_Nutrition',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Micronutrients',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'P_&_E_H',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Read_b4_u_eat_Eng',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Read_b4_u_eat_hin',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Snakes_ladders_of_Nutrition-1',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'Tasty_Bites',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
            ContainerWidget(
              text: 'The_goodness_of_greens',
              icon: Icons.arrow_forward,
              onTap: () {
                _launchURL("https://example.com/link3");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const ContainerWidget(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TColor.primaryColor1,
          borderRadius: BorderRadius.circular(20), // Added border radius
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 300,
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.white, fontSize: AppFontSizes.mediumDefault),
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
