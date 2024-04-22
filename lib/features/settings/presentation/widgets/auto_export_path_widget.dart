// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

// Project imports:
import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/core/enum/box_types.dart';
import 'package:paisa/core/widgets/paisa_widget.dart';
import 'package:paisa/main.dart';

class DefaultAutoExportPathWidget extends StatefulWidget {
  const DefaultAutoExportPathWidget({
    super.key, 
    this.currentPath
    });

  final String? currentPath;

  @override
  DefaultAutoExportPathWidgetState createState() =>
      DefaultAutoExportPathWidgetState();
}

class DefaultAutoExportPathWidgetState
    extends State<DefaultAutoExportPathWidget> {
  late String path = widget.currentPath ?? '/';

  final TextEditingController autoExportPathController =
      TextEditingController();

  @override
  void initState () {
    // super.initState();
    autoExportPathController.text = settings.get(autoExportPath, defaultValue: '/');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              context.loc.autoExportPath,
              style: context.titleLarge,
            ),
          ),
          Expanded(
            //
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: PaisaTextFormField(
                maxLines: 1,
                controller: autoExportPathController,
                hintText: "/",
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return null;
                  } else {
                    return context.loc.validName;
                  }
                },
                  onChanged: (value) {
                    path = value!;
                    setState(() {});
            
                  }
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    context.loc.cancel,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () => {
                    debugPrint("path to save: " + path),
                    getIt
                      .get<Box<dynamic>>(instanceName: BoxType.settings.name)
                      .put(autoExportPath, path)
                      .then((value) => Navigator.pop(context))

                    },
                  child: Text(context.loc.ok),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
