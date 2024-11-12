import 'package:auto_route/auto_route.dart';
import 'package:birthdays_reminder/core/services/google_drive/google_drive_service.dart';
import 'package:birthdays_reminder/core/utils/constants/Palette.dart';
import 'package:birthdays_reminder/core/utils/snack_bar/snack_bar.dart';
import 'package:birthdays_reminder/features/backup_restore/bloc/google_drive_bloc.dart';
import 'package:birthdays_reminder/features/backup_restore/bloc/google_drive_event.dart';
import 'package:birthdays_reminder/features/backup_restore/bloc/google_drive_state.dart';
import 'package:birthdays_reminder/features/backup_restore/widgets/login_logout_button.dart';
import 'package:birthdays_reminder/features/backup_restore/widgets/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/components/progress_indicator.dart';
import '../../generated/l10n.dart';
import '../../router/router.dart';

@RoutePage()
class BackupRestorePage extends StatelessWidget {
  const BackupRestorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleDriveBloc(
        context.read<GoogleDriveService>(),
      )..add(GoogleDriveLogin()),
      child: BackupRestoreView(),
    );
  }
}

class BackupRestoreView extends StatelessWidget {
  const BackupRestoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).googleDrive),
        centerTitle: true,
      ),
      body: BlocConsumer<GoogleDriveBloc, GoogleDriveState>(
        listener: (context, state) {
          if (state.status == GoogleDriveStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(
                  context, S.of(context).errorN(state.errorMessage ?? ""),
                  color: Palette.unfinishedColor),
            );
          } else if (state.status == GoogleDriveStatus.uploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(
                  context, S.of(context).backupCompletedSuccessfully,
                  color: Palette.successColor),
            );
          } else if (state.status == GoogleDriveStatus.downloaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(
                  context, S.of(context).restoreCompletedSuccessfully,
                  color: Palette.successColor),
            );
            AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
                predicate: (Route<dynamic> route) => false);
          } else if (state.status == GoogleDriveStatus.loggedOut) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(
                context,
                S.of(context).loggedOutSuccessfully,
              ),
            );
            Navigator.pop(
                context); // Возвращаемся на предыдущий экран после выхода
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              state.status == GoogleDriveStatus.loading
                  ? const AppProgressIndicator()
                  : SizedBox(),
              state.isLoggedIn
                  ? ProfileWidget(
                      username: state.username ?? "",
                      email: state.email ?? "",
                      uriPhoto: state.uriPhoto ?? "",
                    )
                  : const SizedBox(),
              LoginLogoutButton(
                isLogin: state.isLoggedIn,
                onTap: !state.isLoggedIn
                    ? () {
                        context.read<GoogleDriveBloc>().add(GoogleDriveLogin());
                      }
                    : () {
                        context
                            .read<GoogleDriveBloc>()
                            .add(GoogleDriveLogout());
                      },
              ),
            ],
          );
        },
      ),
    );
  }
}
