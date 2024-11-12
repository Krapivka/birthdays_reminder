import 'package:auto_size_text/auto_size_text.dart';
import 'package:birthdays_reminder/features/backup_restore/bloc/google_drive_bloc.dart';
import 'package:birthdays_reminder/features/backup_restore/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../bloc/google_drive_event.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget(
      {super.key,
      required this.email,
      required this.uriPhoto,
      required this.username});
  final String username;
  final String email;
  final String uriPhoto;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          SizedBox(height: 40),
          Stack(
            children: [
              Container(
                height: 300,
                margin: const EdgeInsets.fromLTRB(14, 55, 14, 5),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 50, 8, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AutoSizeText(
                        username,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      AutoSizeText(
                        email,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.normal),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CustomButton(
                              onTap: () {
                                context
                                    .read<GoogleDriveBloc>()
                                    .add(GoogleDriveBackup());
                              },
                              icon: Icon(
                                Icons.backup,
                                size: 35,
                              ),
                              text: S.of(context).backup),
                          CustomButton(
                              onTap: () {
                                context
                                    .read<GoogleDriveBloc>()
                                    .add(GoogleDriveRestore());
                              },
                              icon: Icon(
                                Icons.restore,
                                size: 35,
                              ),
                              text: S.of(context).recovery),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(uriPhoto, scale: 0.8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
