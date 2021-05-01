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
  final Widget Function(
    types.Message,
    int? index,
    Animation<double> animation,
    bool showDate,
    int? indexToDelayHeader,
    bool isRemoving,
  ) itemBuilder;

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late List<types.Message> oldData = List.from(widget.items);
  int? indexToDelayHeader;

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
          print(oldList.map((e) => e.toJson()));
          print(pos);
          final item = oldList[pos];
          final nextItem = pos + 1 < oldData.length ? oldData[pos + 1] : null;
          final showDate = nextItem == null ||
              DateTime.fromMillisecondsSinceEpoch(
                    item.timestamp! * 1000,
                  )
                      .difference(DateTime.fromMillisecondsSinceEpoch(
                        nextItem.timestamp! * 1000,
                      ))
                      .inSeconds >=
                  3;

          // setState(() {
          indexToDelayHeader = pos - 1;
          // print('KEK');
          // });

          _listKey.currentState?.removeItem(
            pos,
            (_, animation) =>
                _buildRemovedMessage(item, animation, showDate, null),
          );
        },
        change: (pos, payload) =>
            print('changed on $pos with payload $payload'),
        move: (from, to) => print('move $from to $to'),
      );
    }

    oldData = List.from(widget.items);
  }

  Widget _buildRemovedMessage(
    types.Message item,
    Animation<double> animation,
    bool showHeader,
    int? indexToDelayHeader,
  ) {
    return SizeTransition(
      axisAlignment: -1,
      sizeFactor: animation.drive(CurveTween(curve: Curves.easeInQuad)),
      child: FadeTransition(
        opacity: animation.drive(CurveTween(curve: Curves.easeInQuad)),
        // child: Container(
        //   color: Colors.red,
        //   height: 200,
        //   width: 200,
        // ),
        child: Column(
          children: [
            // Container(
            //   // margin: const EdgeInsets.only(
            //   //   bottom: 32,
            //   //   top: 16,
            //   // ),
            //   // width: animation.value,
            //   child: const Text('Today'),
            // ),
            widget.itemBuilder(
              item,
              null,
              animation,
              showHeader,
              null,
              false,
            ),
          ],
        ),
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
      final nextItem = index + 1 < oldData.length ? oldData[index + 1] : null;
      // print(nextItem?.toJson());
      final showDate = nextItem == null ||
          DateTime.fromMillisecondsSinceEpoch(
                item.timestamp! * 1000,
              )
                  .difference(DateTime.fromMillisecondsSinceEpoch(
                    nextItem.timestamp! * 1000,
                  ))
                  .inSeconds >=
              3;

      // print(item.toJson());
      // print(index);
      // print('LOL');
      // print(indexToDelayHeader);

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
          child: widget.itemBuilder(
              item, index, animation, showDate, indexToDelayHeader, false),
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
