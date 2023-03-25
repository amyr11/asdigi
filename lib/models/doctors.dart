import 'dart:ui';
import 'package:flutter/src/widgets/image.dart';

class Doctor {
  final Image profilePic;
  final String name;
  final String occupation;
  final String jobDescription;
  final String hospital;
  final String address;
  final String trunkLine;

  Doctor(this.profilePic, this.name, this.occupation, this.jobDescription,
      this.hospital, this.address, this.trunkLine);
}
