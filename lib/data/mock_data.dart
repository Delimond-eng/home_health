import 'package:flutter/material.dart';

import '../models/infirmier.dart';
import '../views/widgets/medic_doc_item.dart';
import '../views/widgets/schedule_tile.dart';

List<Patient> patientsList = [
  Patient(
    adresse:
        "088, Bateke, Q.Mont des arts, Bandalungwa kinshasa, Ref. Paroisse St Antoine",
    color: Colors.red,
    nom: "Isaac Lebo",
    dateHour: "22 Fév 2024 16:30",
    soins: [
      Soin(libelle: "Injection metronidazol 5ml "),
      Soin(libelle: "Injection amoxy 5ml  "),
      Soin(libelle: "1000mg paracetamol comprimé"),
      Soin(
          libelle:
              "Perfusion schema malaria(1 poches d'eau et quinine lique !) "),
      Soin(libelle: "500mg Tanizol Comprimé "),
    ],
  ),
  Patient(
    adresse: "03, Bismark, Q.Golf, Gombe kinshasa, Ref. Terrain maman Yemo",
    color: Colors.blue,
    nom: "Gaston Delimond",
    dateHour: "12 Fév 2024 13:30",
    soins: [
      Soin(
          libelle:
              "Perfusion schema malaria(1 poches d'eau et quinine lique !) "),
      Soin(libelle: "Injection amoxy 5ml  "),
      Soin(libelle: "1000mg paracetamol comprimé"),
      Soin(libelle: "Injection metronidazol 5ml "),
      Soin(libelle: "500mg Tanizol Comprimé "),
    ],
  ),
  Patient(
    adresse:
        "044 bis, Itaga, Q.Commerce, Barumbu kinshasa, Ref. Marché central",
    color: Colors.grey,
    nom: "Ilunga Luendo",
    dateHour: "04 Fév 2024 14:00",
    soins: [
      Soin(
          libelle:
              "Perfusion schema malaria(1 poches d'eau et quinine lique !) "),
      Soin(libelle: "Injection amoxy 5ml  "),
      Soin(libelle: "1000mg paracetamol comprimé"),
      Soin(libelle: "Injection metronidazol 5ml "),
      Soin(libelle: "500mg Tanizol Comprimé "),
    ],
  ),
  Patient(
    adresse: "05, Madinga, Q.Brikin, Ngaliema kinshasa, Ref. Collège St Damien",
    color: Colors.green,
    nom: "Lionnel Nawej",
    dateHour: "01 Fév 2024 12:30",
    soins: [
      Soin(libelle: "1000mg paracetamol comprimé"),
      Soin(libelle: "Injection amoxy 5ml  "),
      Soin(libelle: "Injection metronidazol 5ml "),
      Soin(
          libelle:
              "Perfusion schema malaria(1 poches d'eau et quinine lique !) "),
      Soin(libelle: "500mg Tanizol Comprimé "),
    ],
  ),
];

List<Schedule> schedules = [
  Schedule(
      title: "Mme Julie Tshela",
      adresse: "0304, Tombalbay, Gombe Kinshasa, Ref. Station cobil",
      dateHour: "04 Fév 2024 08:30",
      color: Colors.blue,
      infirmier: "I. Gaston delimond"),
  Schedule(
      title: "Mme. Dupont Labelle",
      adresse: "1629, Bobozo, 7ieme rue Limete, Ref. Collège Cartesien",
      dateHour: "03 Fév 2024 12:30",
      color: Colors.red,
      infirmier: 'I. Lionnel Nawej'),
  Schedule(
      title: "Mr. Martin Bamba",
      adresse: "1704, Tumbumani, Yolo nord, Kalamu",
      dateHour: "05 Fév 2024 11:30",
      color: Colors.blue,
      infirmier: 'I. Isaac Lebo'),
  Schedule(
    title: "Mme. Garcia Luendo",
    adresse: "12 bis, Huillerie, Kinshasa, Ref. Eglise protestant",
    dateHour: "08 Fév 2024 14:30",
    color: Colors.grey,
    infirmier: 'I. Guy Diku',
  ),
];

List<Infirmier> infirmiers = [
  Infirmier(nom: "Gaston delimond"),
  Infirmier(nom: "Lionnel nawej"),
  Infirmier(nom: "Guy Diku"),
  Infirmier(nom: "Isaac mabuki"),
];
