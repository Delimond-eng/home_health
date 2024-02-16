import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/services/api.manger.dart';

import '../../../utils/costum_modal.dart';
import '../../widgets/login_field.dart';
import '../../widgets/submit_button_loader.dart';

void showCreateNurseModal(BuildContext context) {
  bool isLoading = false;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtPhone = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtAddress = TextEditingController();
  return showCustomModal(
    context,
    modalTitle: "Création patient",
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          LoginField(
            icon: "profile",
            hintText: "Nom complet... *",
            controller: txtName,
          ),
          const SizedBox(
            height: 10,
          ),
          LoginField(
            icon: "phone",
            hintText: "Téléphone... *",
            controller: txtPhone,
          ),
          const SizedBox(
            height: 10,
          ),
          LoginField(
            icon: "email",
            hintText: "Adresse email... *",
            controller: txtEmail,
          ),
          const SizedBox(
            height: 10,
          ),
          LoginField(
            icon: "map-pin",
            hintText: "Adresse du patient... *",
            controller: txtAddress,
          ),
          const SizedBox(
            height: 10,
          ),
          StatefulBuilder(builder: (context, setter) {
            return SizedBox(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: SubmitBtnLoader(
                isLoading: isLoading,
                label: "Sauvegarder",
                color: Colors.green,
                onPressed: () {
                  if (txtName.text.isEmpty) {
                    EasyLoading.showToast(
                        "Nom complet du patient est requis !");
                    return;
                  }
                  if (txtPhone.text.isEmpty) {
                    EasyLoading.showToast("Numéro de téléphone requis !");
                    return;
                  }
                  if (txtAddress.text.isEmpty) {
                    EasyLoading.showToast("L'adresse du patient est requis !");
                    return;
                  }
                  setter(() => isLoading = true);
                  ApiManager.createPatient(data: {
                    "fullname": txtName.text,
                    "address": txtAddress.text,
                    "phone": txtPhone.text
                  }).then((result) {
                    if (result != null) {
                      EasyLoading.showSuccess(
                        "Le Patient a été créé avec succès !",
                      );
                      dataController.initDoctorData();
                      Get.back();
                    }
                  });
                },
              ),
            );
          })
        ],
      ),
    ),
  );
}
