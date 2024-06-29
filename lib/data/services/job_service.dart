import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gym/data/models/job_model.dart';

class JobService {
  final _store = FirebaseFirestore.instance;

  //?get all jobs
  Future<List<Job>> getAllJobs() async {
    List<Job> jobs = [];
    var snapshot = await _store
        .collection('jobs')
        .withConverter<Job>(
          fromFirestore: Job.fromFirestore,
          toFirestore: (job, options) => job.toFirestore(),
        )
        .get();

    for (var doc in snapshot.docs) {
      var job = doc.data();
      jobs.add(job);
    }
    return jobs;
  }

  //?add job
  Future<void> addJob(Job job) async {
    await _store
        .collection('jobs')
        .withConverter<Job>(
          fromFirestore: Job.fromFirestore,
          toFirestore: (job, options) => job.toFirestore(),
        )
        .add(job);
  }
}
