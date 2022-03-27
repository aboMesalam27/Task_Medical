import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';

var faker = Faker();

class Patient {
  late String email;
  late MedicalCenter medicalCenter;
  late String name;
  late String phone;

  Patient.fromJson(var json) {
    email = json['email'];
    medicalCenter =
        data.firstWhere((element) => element.name == json['medicalCenter']);
    name = json['name'];
    phone = json['phone'];
  }
}

class Doctor {
  late String name;
  late String address;

  Doctor({required this.name, required this.address,});
}

class MedicalCenter {
  late String name;

  MedicalCenter(
      {required this.name,
      required this.id,
      required this.address,
      required this.openingTime,
      required this.closingTime,
      required this.doctors});

  late int id;
  late String address;
  late String openingTime;
  late String closingTime;
  late List<Doctor> doctors;
}

List<MedicalCenter> data = [
  MedicalCenter(
      name: 'Oncology Hospital',
      id: 1,
      address: '',
      openingTime: '12:00 Am',
      closingTime: '12:00 Pm',
      doctors: [
        for (int i = 0; i < 5; i++)
          Doctor(
              name: faker.person.name(),
              address: faker.address.streetAddress(),
              ),
      ]),
  MedicalCenter(
      name: "Medical Examination Center",
      id: 2,
      address: 'address',
      openingTime: '12:00 Am',
      closingTime: '12:00 Pm',
      doctors: [
        for (int i = 0; i < 5; i++)
          Doctor(
              name: faker.person.name(),
              address: faker.address.streetAddress(),
              ),
      ]),
  MedicalCenter(
      name: "X-Rays And Analyzes",
      id: 3,
      address: 'address',
      openingTime: '12:00 Am',
      closingTime: '12:00 Pm',
      doctors: [
        for (int i = 0; i < 5; i++)
          Doctor(
            name: faker.person.name(),
            address: faker.address.streetAddress(),
          ),
      ])
];
