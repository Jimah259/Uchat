// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/features/status/controller/status_controller.dart';
import 'package:whatsapp_ui/features/status/screens/confirm_status_screen.dart';
import 'package:whatsapp_ui/features/status/screens/status_screen.dart';
import 'package:whatsapp_ui/models/status_model.dart';

class StatusContactsScreen extends ConsumerWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.data!.isEmpty) {
          return Scaffold(
            body: Center(
              child: const Text(
                'No Status posted',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                File? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  Navigator.pushNamed(
                    context,
                    ConfirmStatusScreen.routeName,
                    arguments: pickedImage,
                  );
                }
              },
              child: const Icon(Icons.camera_alt),
            ),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'Something went wrong',
            style: TextStyle(fontSize: 20, color: Colors.black),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            log('message');
            return Scaffold(
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StatusScreen.routeName,
                        arguments: statusData,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          statusData.username,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            statusData.profilePic,
                          ),
                          radius: 30,
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: dividerColor, indent: 85),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  File? pickedImage = await pickImageFromGallery(context);
                  if (pickedImage != null) {
                    Navigator.pushNamed(
                      context,
                      ConfirmStatusScreen.routeName,
                      arguments: pickedImage,
                    );
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),
            );
          },
        );
      },
    );
  }
}
