import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

Future jump(ItemScrollController _scrollController, int index) async {
  _scrollController.jumpTo(index: index, alignment: 0.5);
}
