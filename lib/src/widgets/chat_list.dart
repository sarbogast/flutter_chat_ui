import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatList extends StatefulWidget {
  const ChatList({
    Key? key,
    required this.itemBuilder,
    required this.items,
  }) : super(key: key);

  final List<types.Message> items;
  final Widget Function(types.Message, int? index) itemBuilder;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<types.Message> oldData = List.from(widget.items);

  @override
  void initState() {
    super.initState();

    didUpdateWidget(widget);
  }

  @override
  void didUpdateWidget(covariant ChatList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _calculateDiffs(oldWidget.items);
  }

  void _calculateDiffs(List<types.Message> oldList) async {
    final diffResult = calculateListDiff<types.Message>(
      oldList,
      widget.items,
      equalityChecker: (item1, item2) => item1.id == item2.id,
    );

    for (final update in diffResult.getUpdates(batch: false)) {
      update.when(
        insert: (pos, count) => _listKey.currentState?.insertItem(pos),
        remove: (pos, count) {
          final item = oldList[pos];
          _listKey.currentState?.removeItem(
            pos,
            (_, animation) => _buildRemovedMessage(item, animation),
          );
        },
        change: (pos, payload) =>
            print('changed on $pos with payload $payload'),
        move: (from, to) => print('move $from to $to'),
      );
    }

    oldData = List.from(widget.items);
  }

  Widget _buildRemovedMessage(types.Message item, Animation<double> animation) {
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
      child: FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        child: widget.itemBuilder(item, null),
      ),
    );
  }

  // Widget _buildMessage(types.Message item) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     margin: const EdgeInsets.all(8),
  //     color: Colors.lightGreen[50],
  //     child: Text(item.text),
  //   );
  // }

  Widget _buildNewMessage(int index, Animation<double> animation) {
    try {
      final item = oldData[index];

      return SizeTransition(
        axisAlignment: -1,
        sizeFactor: animation.drive(CurveTween(curve: Curves.easeOutQuad)),
        child: SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).chain(
              CurveTween(curve: Curves.easeOutQuad),
            ),
          ),
          child: widget.itemBuilder(item, index),
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      initialItemCount: widget.items.length,
      key: _listKey,
      reverse: true,
      itemBuilder: (_, index, animation) => _buildNewMessage(
        index,
        animation,
      ),
    );
  }
}
