import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';
import 'package:nin2byo2i/Common/colo_extension.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';

//add review page for books
class AddReviewPage extends StatefulWidget {
  final int bookId;

  const AddReviewPage({super.key, required this.bookId});

  @override
  _AddReviewPageState createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  TextEditingController commentController = TextEditingController();
  double rating = 0.0;
  final UserProfileController _controller = UserProfileController();

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
              width: 15,
              height: 15,
              color: ThemeManager.themeText,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Add Review",
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Book ID: ${widget.bookId}'),
            TextFormField(
              controller: commentController,
              decoration: const InputDecoration(labelText: 'Add Comments'),
            ),
            const SizedBox(height: 20),
            const Text('Rating:'),
            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _controller.addReview(
                    widget.bookId,
                    commentController.text,
                    rating,
                  );

                  // Handle success, e.g., show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content:
                          Text(Languages.of(context)!.reviewAddedSuccessfully),
                    ),
                  );

                  // Navigate back to the previous screen
                  Navigator.pop(context);
                } catch (e) {
                  // Handle error, e.g., show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content:
                          Text('${Languages.of(context)!.failedToAddReview}$e'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColor
                    .secondaryColor1, // Set the background color to light blue
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25.0), // Set the border radius
                ),
              ),
              child: Text(Languages.of(context)!.labelSubmit),
              // child: Text('Add Review'),
            ),
          ],
        ),
      ),
    );
  }
}
