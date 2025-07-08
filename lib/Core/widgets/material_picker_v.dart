import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moatmat_uploader/Core/injection/app_inj.dart';
import 'package:moatmat_uploader/Core/widgets/toucheable_tile_widget.dart';
import 'package:moatmat_uploader/Presentation/notifications/state/notifications_bloc/notifications_bloc.dart';
import 'package:moatmat_uploader/Presentation/notifications/views/notifications_view.dart';

import '../../../Core/resources/sizes_resources.dart';
import '../../../Core/resources/spacing_resources.dart';
import '../../../Core/resources/texts_resources.dart';
import '../constant/materials.dart';
import 'appbar/search_icon_w.dart';

class MaterialPickerView extends StatefulWidget {
  const MaterialPickerView({
    super.key,
    required this.onPick,
    this.onSearch,
  });
  final Function(String) onPick;
  final Function(String)? onSearch;

  @override
  State<MaterialPickerView> createState() => _MaterialPickerViewState();
}

class _MaterialPickerViewState extends State<MaterialPickerView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppBarTitles.materialPicker),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotificationsView(),
                ),
              );
            },
            icon: const Stack(
              children: [
                Icon(
                  Icons.notifications,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.transparent,
                  ),
                )
              ],
            ),
          ),
          if (widget.onSearch != null)
            SearchIconWidget(
              onSearch: widget.onSearch!,
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(
          top: SizesResources.s2,
          left: SpacingResources.sidePadding,
          right: SpacingResources.sidePadding,
          bottom: SizesResources.s10 * 2,
        ),
        itemCount: materialsLst.length,
        itemBuilder: (context, index) {
          return TouchableTileWidget(
            title: materialsLst[index]["name"]!,
            onTap: () {
              widget.onPick(materialsLst[index]["name"]!);
            },
          );
        },
      ),
    );
  }
}
