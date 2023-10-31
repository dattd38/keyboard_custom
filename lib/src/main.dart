import 'package:custom_keyboard/src/theme/keyboard_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'controller/dynamic_keyboard_controller.dart';

class DynamicKeyboard extends StatefulWidget {
  final KeyboardTheme theme;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback onDone;
  final TextEditingController controller;
  final String keyType;

  const DynamicKeyboard(
      {super.key,
      required this.theme,
      this.autofocus = false,
      this.focusNode,
      required this.onDone,
      required this.controller,
      this.keyType = 'INT'});

  @override
  State<DynamicKeyboard> createState() => _DynamicKeyboardState();
}

class _DynamicKeyboardState extends State<DynamicKeyboard> {
  late DynamicKeyboardController _controllerKeyboard;
  late String _numberFormat;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controllerKeyboard = DynamicKeyboardController();
    _numberFormat = NumberFormat().symbols.DECIMAL_SEP;
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) {
    return _girdCustomWidget();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _girdCustomWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    _childWidget(
                        title: '1',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '2',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '3',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _childWidget(
                        title: '4',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '5',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '6',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                  ],
                ),
              ],
            ),
            _childWidget(
                type: '',
                title: '⌫',
                padding: 4,
                column: 2,
                row: 4,
                heightW: 0.26,
                radius: 4),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    _childWidget(
                        title: '7',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '8',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '9',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _childWidget(
                        title: '000',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: '0',
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                    _childWidget(
                        title: _numberFormat,
                        padding: 4,
                        column: 4,
                        row: 4,
                        heightW: 0.28,
                        radius: 4),
                  ],
                ),
              ],
            ),
            _childWidget(
                type: 'DONE',
                title: 'Done',
                padding: 4,
                column: 2,
                row: 4,
                heightW: 0.26,
                radius: 4),
          ],
        )
      ],
    );
  }

  Widget _childWidget(
      {required String title,
      required double padding,
      required int column,
      required int row,
      required double heightW,
      required double radius,
      String type = 'NUM'}) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(padding),
      width: (size.width - padding * row * 3) / row,
      height: (size.height * heightW - padding * column * 4) / column,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Color(0xff565758), blurRadius: 1, offset: Offset(0, 2)),
          ],
          color: type == 'NUM'
              ? Colors.white
              : type == 'DONE'
                  ? (_controller.text.isEmpty ? widget.theme.operatorColor : Colors.blue )
                  : widget.theme.commandColor,
          borderRadius: BorderRadius.circular(radius)),
      child: TextButton(
        onLongPress: (){
          setState(() {
            if(title.contains('⌫')){
              _controller.clear();
            }
          });
        },
        onPressed: () {
          // _focusNode.requestFocus();
          setState(() {
            switch (title) {
              case '⌫':
                _controllerKeyboard.backspace(_controller);
                break;
              case '000':
                _controllerKeyboard.insertText(_controller, '000');
                break;
              case 'Done':
                widget.onDone.call();
                break;
              default:
                if (widget.keyType.contains('INT')) {
                  if (!title.contains(_numberFormat)) {
                    _controllerKeyboard.insertText(_controller, title);
                  }
                } else {
                  _controllerKeyboard.insertText(_controller, title);
                }
            }
          });
        },
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: type == 'NUM'
              ? widget.theme.numStyle
              : type == 'DONE'
                  ? (widget.theme.operatorStyle?.copyWith(
                      color: _controller.text.isEmpty ? null : Colors.white))
                  : widget.theme.commandStyle,
        ),
      ),
    );
  }
}
