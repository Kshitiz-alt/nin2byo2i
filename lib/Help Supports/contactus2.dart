import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nin2byo2i/Controller/user_profile_controller.dart';
import 'package:nin2byo2i/Language/localization/Language/languages.dart';
import 'package:nin2byo2i/common_widget/CustomTextEditing.dart';
import 'package:nin2byo2i/common_widget/round_button.dart';
import 'package:nin2byo2i/Common/ThemeColor.dart';
import 'package:nin2byo2i/custom%20widgets/sized_box.dart';
import 'package:nin2byo2i/Common/appfontsize.dart';

//contact us page
class ContactUsPage2 extends StatefulWidget {
  const ContactUsPage2({super.key});

  @override
  _ContactUsPage2State createState() => _ContactUsPage2State();
}

class _ContactUsPage2State extends State<ContactUsPage2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  File? _imageFile;

  Future<void> _sendContactUsFeedback() async {
    final UserProfileController controller = UserProfileController();

    bool success = await controller.sendContactUsFeedback(
      name: _nameController.text,
      number: _phoneController.text,
      email: _emailController.text,
      queries: _messageController.text,
      requestType: _selectedOption,
      imagePath: _imageFile != null ? _imageFile!.path : "",
    );

    if (success) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themelightColor,
            title: Text(
              Languages.of(context)!.messageSent,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Text(
              Languages.of(context)!.thankYouForContactingUs,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    } else {
      // Handle failure or show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ThemeManager.themelightColor,
            title: Text(
              Languages.of(context)!.alert,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            content: Text(
              Languages.of(context)!.failed,
              style: TextStyle(color: ThemeManager.themeText),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pop();
                },
                child: Text(
                  Languages.of(context)!.ok,
                  style: TextStyle(color: ThemeManager.themeText),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  String _selectedOption = 'Contact Us';

  void _onDropdownChanged(String? newValue) {
    setState(() {
      _selectedOption = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userProfileController =
    //     Provider.of<UserProfileController>(context, listen: false);
    // final userProfile = userProfileController.userProfile;
    // final userName =
    //     '${userProfile?.firstName == null ? "" : userProfile?.firstName} ${userProfile?.lastName == null ? "" : userProfile?.lastName}';
    // if (userProfile?.firstName != null) {
    //   _nameController.text = userName;
    // }

    // _emailController.text = userProfile?.email ?? '';
    // _phoneController.text = userProfile?.mobile ?? '';

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
          // Languages.of(context)!.labelContactUs,
          '${Languages.of(context)!.TextAppContactUs}/ ${Languages.of(context)!.TextAppReportBug}',
          style: TextStyle(
              color: ThemeManager.themeText,
              fontSize: AppFontSizes.mediumDefault,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: ThemeManager.themeColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 189, 20, 124), // Background color of dropdown
                      borderRadius: BorderRadius.circular(
                          10.0), // Border radius of dropdown
                    ),
                    child: DropdownButton<String>(
                      value: _selectedOption,
                      onChanged: _onDropdownChanged,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: const Color.fromARGB(255, 189, 20, 124),
                      icon: const Icon(Icons.expand_more, color: Colors.white),
                      underline: Container(),
                      menuMaxHeight: 400, // Removes the default underline
                      items: <String>[
                        'Contact Us',
                        'Report Bug',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                sizedBox12(),
                CustomTextField(
                  icon: Icons.person,
                  labelText: Languages.of(context)!.labelName,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                ),
                sizedBox12(),
                CustomTextField(
                  icon: Icons.email,
                  labelText: Languages.of(context)!.labelEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                sizedBox12(),
                CustomTextField(
                  icon: Icons.phone,
                  labelText: Languages.of(context)!.labelPhoneNumber,
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                ),

                sizedBox12(),
                Container(
                  width: 395,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: ThemeManager.themelightColor,
                  ),
                  child: TextFormField(
                    controller: _messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ThemeManager.themelightColor,
                      labelText: Languages.of(context)!.labelMessage,
                      labelStyle: TextStyle(
                        color: ThemeManager.themeText,
                        fontSize: AppFontSizes.smallDefault,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(
                        Icons.message,
                        color: ThemeManager.themeText,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(),
                  ),
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: ThemeManager.themelightColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        // height: 30,
                        child: RoundButton(
                          title: _imageFile != null
                              ? Languages.of(context)!.NINTextChangeImage
                              : Languages.of(context)!.TextAppAttachImage,
                          type: RoundButtonType.bgGradient,
                          fontSize: AppFontSizes.mediumDefault,
                          fontWeight: FontWeight.w400,
                          onPressed: () async {
                            debugPrint("efdgvbfgbgf 1");
                            final pickedFile = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            debugPrint("efdgvbfgbgf 2");
                            if (pickedFile != null) {
                              setState(() {
                                _imageFile = File(pickedFile.path);
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (_imageFile != null)
                        Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  _imageFile!,
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _imageFile = null;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                sizedBox30(),
                SizedBox(
                  width: 200,
                  child: RoundButton(
                      title: Languages.of(context)!.labelSubmit,
                      type: RoundButtonType.bgGradient,
                      fontSize: AppFontSizes.mediumDefault,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Validate form fields before sending feedback
                          _sendContactUsFeedback();
                        }
                      }),
                ),

                const SizedBox(height: 20),
                Text(
                  '${Languages.of(context)!.labelContactUs}:',
                  style: TextStyle(
                    fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.themeText,
                  ),
                ),

                Text(
                  '${Languages.of(context)!.labelAddress}:',
                  style: TextStyle(
                    // fontSize: AppFontSizes.mediumDefault,
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.themeText,
                  ),
                ),
                Text(
                  'ICMR - National Institute of Nutrition',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),

                Text(
                  'Jamai-Osmania PO,',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                Text(
                  'Hyderabad-500 007, India.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                Text(
                  '${Languages.of(context)!.labelPhoneNumber}:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '+914027197200',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                Text(
                  '${Languages.of(context)!.labelEmail}:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'nutrifyindianow.nin@gmail.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
                // Text(
                //   "${Languages.of(context)!.labelDirectorsEmail}:",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: ThemeManager.themeText,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Text(
                //   'directornin@icmr.gov.in, dirnin_hyd@yahoo.co.in',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     color: ThemeManager.themeText,
                //   ),
                // ),
                Text(
                  '${Languages.of(context)!.labelFax}:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '04027019074',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeManager.themeText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
