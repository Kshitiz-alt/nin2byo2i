import 'package:flutter/material.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({super.key});

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
          Languages.of(context)!.ninTextFAQs,
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Column(
            children: [
              FAQCard(
                question: Languages.of(context)!.question1,
                answer: Languages.of(context)!.answer1,
                linkText: 'Click here to edit your personal details',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/edit_profile');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question2,
                answer: Languages.of(context)!.answer2,
                linkText: 'Click here to edit your contact details',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/edit_contact');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question3,
                answer: Languages.of(context)!.answer3,
                linkText: 'Click here to change your password',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/change_password');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question4,
                answer: Languages.of(context)!.answer4,
                linkText: 'Click here to use the BMI calculator',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/bmi_calculator');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question5,
                answer: Languages.of(context)!.answer5,
                linkText: 'Click here to track your weight',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/weight_tracker');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question6,
                answer: Languages.of(context)!.answer6,
                linkText: 'Click here to view your activity',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/activity_tracker');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question7,
                answer: Languages.of(context)!.answer7,
                linkText: 'Click here to set a water intake reminder',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/set_reminder');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question8,
                answer: Languages.of(context)!.answer8,
                linkText: 'Click here to connect your smart watch',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/connect_watch');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question9,
                answer: Languages.of(context)!.answer9,
                linkText: '',
                link: () {},
              ),
              FAQCard(
                question: Languages.of(context)!.question10,
                answer: Languages.of(context)!.answer10,
                linkText: '',
                link: () {},
              ),
              FAQCard(
                question: Languages.of(context)!.question11,
                answer: Languages.of(context)!.answer11,
                linkText: '',
                link: () {},
              ),
              FAQCard(
                question: Languages.of(context)!.question12,
                answer: Languages.of(context)!.answer12,
                linkText: 'Click here to track your sleep',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/sleep_tracker');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question13,
                answer: Languages.of(context)!.answer13,
                linkText: 'Click here to visit the book store',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/book_store');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question14,
                answer: Languages.of(context)!.answer14,
                linkText: 'Click here to create your diet diary',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/diet_diary');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question15,
                answer: Languages.of(context)!.answer15,
                linkText: 'Click here to search for recipes',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/recipe_search');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question16,
                answer: Languages.of(context)!.answer16,
                linkText: 'Click here to check your nutrient intake',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/nutrient_intake');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question17,
                answer: Languages.of(context)!.answer17,
                linkText: 'Click here to search nutrients in raw foods',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/nutrient_raw_ingredients');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question18,
                answer: Languages.of(context)!.answer18,
                linkText: 'Click here to know nutrient composition',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/nutrient_recipe');
                },
              ),
              FAQCard(
                question: Languages.of(context)!.question19,
                answer: Languages.of(context)!.answer19,
                linkText: 'Click here to create a custom recipe',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/custom_recipe');
                },
              ),
              // FAQCard(
              //   question: Languages.of(context)!.question20,
              //   answer: Languages.of(context)!.answer20,
              //   linkText: 'Click here to get dietary recommendations',
              //   link: () {
              //     // Add your navigation logic here
              //     // Example: Navigator.pushNamed(context, '/dietary_recommendations');
              //   },
              // ),
              FAQCard(
                question: Languages.of(context)!.question21,
                answer: Languages.of(context)!.answer21,
                linkText: 'Click here to change language',
                link: () {
                  // Add your navigation logic here
                  // Example: Navigator.pushNamed(context, '/language_settings');
                },
              ),
            ],
          )

          // Add more FAQCards for each question-answer pair
        ],
      ),
    );
  }
}

class FAQCard extends StatelessWidget {
  final String question;
  final String answer;
  final String linkText;
  final Function()? link;

  const FAQCard({super.key, 
    required this.question,
    required this.answer,
    required this.linkText,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Card(
      elevation: 2.0,
      color: ThemeManager.themeColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: media.width * 0.95,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.justify,
                question,
                style: TextStyle(
                  fontSize: AppFontSizes.mediumDefault,
                  color: ThemeManager.themeText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                textAlign: TextAlign.justify,
                answer,
                style: TextStyle(
                    color: ThemeManager.themeText,
                    fontSize: AppFontSizes.mediumDefault),
              ),
              const SizedBox(height: 8.0),
              // GestureDetector(
              //   onTap: link,
              //   child: Text(
              //     linkText,
              //     style: TextStyle(
              //       color: Colors.blue,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FAQsPage(),
  ));
}
