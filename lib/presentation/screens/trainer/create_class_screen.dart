import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/class_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/class_bloc/class_bloc.dart';
import 'package:gym/logic/image_bloc/image_bloc.dart';
import 'package:gym/logic/upload_bloc/upload_bloc.dart';
import 'package:gym/presentation/widgets/textField.dart';
import 'package:gym/presentation/widgets/toast.dart';
import 'package:lottie/lottie.dart';

class CreateClassScreen extends StatefulWidget {
  final Trainer trainer;
  const CreateClassScreen({super.key, required this.trainer});

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  final _classNameController = TextEditingController();

  final _classDescriptionController = TextEditingController();

  final _classScheduleController = TextEditingController();

  final _classDurationController = TextEditingController();

  final _classLocationController = TextEditingController();

  final _classDifficulityController = TextEditingController();

  final _classCapacityController = TextEditingController();

  final _classEquipmentController = TextEditingController();

  final _classInstructionsController = TextEditingController();

  List<String> equipment = [];

  List<String> instructions = [];

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
              'Add Class Info',
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
                  hint: 'Yoga',
                  controller: _classNameController,
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
                  hint: 'what the class is about',
                  controller: _classDescriptionController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!schedule
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'schedule',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Monday, Wednesday, Friday at 7 AM',
                  controller: _classScheduleController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!duration
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'duration',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: '1 hour',
                  controller: _classDurationController,
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
                  hint: 'studio A',
                  controller: _classLocationController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!difficulty
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'difficulty',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Beginner',
                  controller: _classDifficulityController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!capacity
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'capacity',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: '20',
                  controller: _classCapacityController,
                  inputType: TextInputType.number,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'equipment needed',
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
                itemCount: equipment.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        equipment[index],
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
                          equipment.removeAt(index);
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
                        controller: _classEquipmentController,
                        cursorColor: MyColors.mywhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Yoga mat',
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
                      if (_classEquipmentController.text.isEmpty) return;
                      equipment.add(_classEquipmentController.text);
                      _classEquipmentController.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'special instructions',
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
                itemCount: instructions.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        instructions[index],
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
                          instructions.removeAt(index);
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
                        controller: _classInstructionsController,
                        cursorColor: MyColors.mywhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText:
                              'Arrive early to adjust your bike settings.',
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
                      if (_classInstructionsController.text.isEmpty) return;
                      instructions.add(_classInstructionsController.text);
                      _classInstructionsController.clear();
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
                    final GymClass gymclass = GymClass(
                      name: _classNameController.text.trim(),
                      imagePath: state.imageUrl,
                      instructor:
                          "${widget.trainer.firstName} ${widget.trainer.lastName}",
                      description: _classDescriptionController.text.trim(),
                      schedule: _classScheduleController.text.trim(),
                      duration: _classDurationController.text.trim(),
                      location: _classLocationController.text.trim(),
                      difficulty: _classDifficulityController.text.trim(),
                      capacity: int.parse(_classCapacityController.text),
                      equipmentNeeded: equipment,
                      specialInstructions: instructions,
                      trainerId: widget.trainer.userid,
                      memberIds: [],
                      state: "pending",
                    );
                    context.read<ClassBloc>().add(
                          AddClass(gymclass: gymclass),
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
                    return BlocConsumer<ClassBloc, ClassState>(
                        listener: (context, state) {
                      if (state is ClassAdded) {
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
                      } else if (state is ClassError) {
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
                      if (state is ClassLoading) {
                        return Row(
                          children: [
                            Text(
                              "uploadnig class info",
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
                                path: 'classes/${_classNameController.text}'));
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
                            'Create',
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
