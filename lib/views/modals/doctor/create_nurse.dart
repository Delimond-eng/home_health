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
  final TextEditingController txtPass = TextEditingController();
  return showCustomModal(
    context,
    modalTitle: "Création fiche infirmier",
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
            icon: "lock-password",
            hintText: "Entrez le mot de passe... *",
            controller: txtPass,
            isPassword: true,
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
                  if (txtEmail.text.isEmpty) {
                    EasyLoading.showToast("email requis !");
                    return;
                  }
                  if (txtName.text.isEmpty) {
                    EasyLoading.showToast("Nom complet requis !");
                    return;
                  }
                  if (txtPhone.text.isEmpty) {
                    EasyLoading.showToast("Numéro de téléphone requis !");
                    return;
                  }
                  if (txtPass.text.isEmpty) {
                    EasyLoading.showToast("Mot de passe requis !");
                    return;
                  }
                  setter(() => isLoading = true);
                  ApiManager.createNurse(data: {
                    "email": txtEmail.text,
                    "fullname": txtName.text,
                    "pwd": txtPass.text,
                    "phone": txtPhone.text
                  }).then((result) {
                    if (result != null) {
                      EasyLoading.showSuccess("Infirmier créé avec succès !");
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
