import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final TextEditingController textEditingController;
  final VoidCallback onClose;
  final void Function(String value) onChange;
  const SearchBarWidget({super.key, required this.textEditingController, required this.onClose, required this.onChange});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      leadingWidth: MediaQuery.of(context).size.width,
      leading: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 8,left: 8),
          child: TextFormField(
            controller: widget.textEditingController,
            onChanged: widget.onChange,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: GestureDetector(
                onTap: widget.onClose,
                  child: Icon(
                Icons.close,
                color: Colors.black,
              )),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
