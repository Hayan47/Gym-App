import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/equipment_model.dart';
import 'package:gym/logic/equipment_bloc/equipment_bloc.dart';
import 'package:gym/logic/image_bloc/image_bloc.dart';
import 'package:gym/logic/upload_bloc/upload_bloc.dart';
import 'package:gym/presentation/widgets/textField.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _equipmentNameController = TextEditingController();
  final _equipmentDiscriptionController = TextEditingController();
  final _equipmentLocationController = TextEditingController();
  final _equipmentUsageInstructionsController = TextEditingController();
  final _equipmentSafetyTipsController = TextEditingController();
  final _equipmentTutorialLinksController = TextEditingController();
  List<String> safetyTips = [];

  List<String> tutorialLinks = [];

  late Uint8List image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Text(
              'Add Equipment Info',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            //!name
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Treadmill',
                  controller: _equipmentNameController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'description',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'what the equipment is about',
                  controller: _equipmentDiscriptionController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),

            //!location
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'location',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Cardio Section',
                  controller: _equipmentLocationController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!usageInstructions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'usage instructions',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Start slow and increase speed gradually.',
                  controller: _equipmentUsageInstructionsController,
                  inputType: TextInputType.text,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'safety tips',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: safetyTips.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        safetyTips[index],
                        style: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: MyColors.myOrange2,
                        ),
                        onPressed: () {
                          safetyTips.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: GoogleFonts.nunito(
                          color: MyColors.myGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        controller: _equipmentSafetyTipsController,
                        cursorColor: MyColors.mywhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Wear proper running shoes.',
                          hintStyle: GoogleFonts.nunito(
                            color: MyColors.myGrey.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: MyColors.myOrange2,
                    ),
                    onPressed: () {
                      if (_equipmentSafetyTipsController.text.isEmpty) return;
                      safetyTips.add(_equipmentSafetyTipsController.text);
                      _equipmentSafetyTipsController.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'tutorial links',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tutorialLinks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        tutorialLinks[index],
                        style: GoogleFonts.nunito(
                          color: MyColors.mywhite,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: MyColors.myOrange2,
                        ),
                        onPressed: () {
                          tutorialLinks.removeAt(index);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: GoogleFonts.nunito(
                          color: MyColors.myGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        controller: _equipmentTutorialLinksController,
                        cursorColor: MyColors.mywhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'https://example.com/treadmill-usage',
                          hintStyle: GoogleFonts.nunito(
                            color: MyColors.myGrey.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: MyColors.myOrange2,
                    ),
                    onPressed: () {
                      if (_equipmentTutorialLinksController.text.isEmpty)
                        return;
                      tutorialLinks.add(_equipmentTutorialLinksController.text);
                      _equipmentTutorialLinksController.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'cover image',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                context.read<ImageBloc>().add(const AddImageEvent());
              },
              child: BlocConsumer<ImageBloc, ImageState>(
                listener: (context, state) {
                  if (state is ImageError) {
                    showToastMessage(
                      context,
                      state.errorMessage,
                      const Icon(
                        Icons.error,
                        color: MyColors.myred2,
                        size: 20,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ImageChanged) {
                    image = state.image;
                    return Center(
                      child: SizedBox(
                        child: Card(
                          color: Colors.transparent,
                          child: Image.memory(
                            image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  } else if (state is ImageLoading) {
                    return Center(
                      child: SizedBox(
                        width: 150,
                        child: Lottie.asset('assets/lottie/SplashyLoader.json'),
                      ),
                    );
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: MyColors.myOrange2,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/img/classholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: BlocConsumer<UploadBloc, UploadState>(
                listener: (context, state) {
                  if (state is UploadFailedState) {
                    showToastMessage(
                      context,
                      state.message,
                      const Icon(
                        Icons.error,
                        color: MyColors.myred2,
                        size: 20,
                      ),
                    );
                  } else if (state is UploadSuccessState) {
                    final Equipment equipment = Equipment(
                      name: _equipmentNameController.text.trim(),
                      imagePath: state.imageUrl,
                      description: _equipmentDiscriptionController.text.trim(),
                      location: _equipmentLocationController.text.trim(),
                      usageInstructions:
                          _equipmentUsageInstructionsController.text.trim(),
                      safetyTips: safetyTips,
                      tutorialLinks: tutorialLinks,
                    );
                    context.read<EquipmentBloc>().add(
                          AddEquipmentEvent(equipment: equipment),
                        );
                  }
                },
                builder: (context, state) {
                  if (state is UploadingState) {
                    return Row(
                      children: [
                        Text("uploadnig image",
                            style: GoogleFonts.nunito(
                              color: MyColors.myOrange2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 10),
                        const SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(
                            color: MyColors.myred2,
                            strokeWidth: 2,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return BlocConsumer<EquipmentBloc, EquipmentState>(
                        listener: (context, state) {
                      if (state is EquipmentAdded) {
                        showToastMessage(
                          context,
                          state.message,
                          const Icon(
                            Icons.done,
                            color: Colors.green,
                            size: 20,
                          ),
                        );
                        // AppRouter().disposeAddCarBlocs();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'mainscreen',
                          (Route<dynamic> route) => false,
                        );
                      } else if (state is EquipmentError) {
                        showToastMessage(
                          context,
                          state.message,
                          const Icon(
                            Icons.error,
                            color: MyColors.myred2,
                            size: 20,
                          ),
                        );
                      }
                    }, builder: (context, state) {
                      if (state is EquipmentLoading) {
                        return Row(
                          children: [
                            Text(
                              "uploadnig equipment info",
                              style: GoogleFonts.nunito(
                                color: MyColors.myOrange2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                color: MyColors.myred2,
                                strokeWidth: 2,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return TextButton(
                          onPressed: () async {
                            context.read<UploadBloc>().add(UploadImagesEvent(
                                image: image,
                                path:
                                    'equipment/${_equipmentNameController.text}'));
                          },
                          style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              fixedSize:
                                  WidgetStateProperty.all(const Size(70, 40)),
                              backgroundColor:
                                  WidgetStateProperty.all(MyColors.myOrange2)),
                          child: Text(
                            'Add',
                            style: GoogleFonts.nunito(
                              color: MyColors.mywhite,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
