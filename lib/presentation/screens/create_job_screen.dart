import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym/constants/my_colors.dart';
import 'package:gym/data/models/job_model.dart';
import 'package:gym/data/models/usr_model.dart';
import 'package:gym/logic/jobs_bloc/jobs_bloc.dart';
import 'package:gym/presentation/widgets/textField.dart';
import 'package:gym/presentation/widgets/toast.dart';

class CreateJobScreen extends StatefulWidget {
  final Admin admin;
  const CreateJobScreen({super.key, required this.admin});

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final _jobTitleController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _jobHourlyRateController = TextEditingController();
  final _jobSpecializationsController = TextEditingController();

  List<String> specializations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Text(
              'Add Job Info',
              style: GoogleFonts.nunito(
                color: MyColors.myOrange2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            //!title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'title',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: 'Trainer',
                  controller: _jobTitleController,
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
                  hint: 'what the Job is about',
                  controller: _jobDescriptionController,
                  inputType: TextInputType.name,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            //!hourlyRate
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hourly Rate in \$',
                  style: GoogleFonts.nunito(
                    color: MyColors.myOrange2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                MyTextField(
                  hint: '20',
                  controller: _jobHourlyRateController,
                  inputType: TextInputType.number,
                  actionType: TextInputAction.next,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'specializations',
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
                itemCount: specializations.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: MyColors.myGrey,
                    child: ListTile(
                      dense: true,
                      title: Text(
                        specializations[index],
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
                          specializations.removeAt(index);
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
                        controller: _jobSpecializationsController,
                        cursorColor: MyColors.mywhite,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Bodybuilding',
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
                      if (_jobSpecializationsController.text.isEmpty) return;
                      specializations.add(_jobSpecializationsController.text);
                      _jobSpecializationsController.clear();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: BlocConsumer<JobsBloc, JobsState>(
                listener: (context, state) {
                  if (state is JobAdded) {
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
                  } else if (state is JobsError) {
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
                },
                builder: (context, state) {
                  if (state is JobsLoading) {
                    return Row(
                      children: [
                        Text(
                          "uploadnig job info",
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
                        final Job job = Job(
                          title: _jobTitleController.text.trim(),
                          description: _jobDescriptionController.text.trim(),
                          postedDate: DateTime.now(),
                          specializations: specializations,
                          hourlyRate: double.parse(
                              _jobHourlyRateController.text.trim()),
                          adminPhoneNumber: widget.admin.phoneNumber,
                        );
                        context.read<JobsBloc>().add(AddJob(job: job));
                      },
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
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
