import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'inherited_chat_theme.dart';
import 'inherited_user.dart';

/// A class that represents video message widget
class VideoMessage extends StatefulWidget {
  /// Creates an video message widget based on a [types.VideoMessage]
  const VideoMessage({
    Key? key,
    required this.message,
    required this.messageWidth,
  }) : super(key: key);

  static final durationFormat = DateFormat('m:ss', 'en_US');

  /// [types.VideoMessage]
  final types.VideoMessage message;

  /// Maximum message width
  final int messageWidth;

  @override
  _VideoMessageState createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  late VideoPlayerController _controller;

  bool _videoPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await _controller.dispose();
  }

  Future<void> _initVideoPlayer() async {
    _controller = VideoPlayerController.network(widget.message.uri);
    _controller.addListener(() async {
      setState(() {});
    });
    await _controller.initialize();
    setState(() {
      _videoPlayerReady = true;
    });
  }

  Future<void> _togglePlaying() async {
    if (!_videoPlayerReady) return;
    if (_controller.value.isPlaying) {
      await _controller.pause();
      setState(() {});
    } else {
      if (_controller.value.position >= _controller.value.duration) {
        await _controller.seekTo(const Duration());
      }
      await _controller.play();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = InheritedUser.of(context).user;
    final _background = _user.id == widget.message.authorId
        ? InheritedChatTheme.of(context).theme.primaryColor
        : InheritedChatTheme.of(context).theme.secondaryColor;
    final _foreground = _user.id == widget.message.authorId
        ? InheritedChatTheme.of(context).theme.primaryTextColor
        : InheritedChatTheme.of(context).theme.secondaryTextColor;

    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_controller),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 50),
              reverseDuration: const Duration(milliseconds: 200),
              child: _controller.value.isPlaying
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.black26,
                      child: Center(
                        child: InheritedChatTheme.of(context)
                                    .theme
                                    .playButtonIcon !=
                                null
                            ? Image.asset(
                                InheritedChatTheme.of(context)
                                    .theme
                                    .playButtonIcon!,
                                color: _background,
                              )
                            : Icon(
                                Icons.play_circle_fill,
                                color: _background,
                                size: 44,
                              ),
                      ),
                    ),
            ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor:
                    InheritedChatTheme.of(context).theme.videoTrackPlayedColor,
                bufferedColor: InheritedChatTheme.of(context)
                    .theme
                    .videoTrackBufferedColor,
                backgroundColor: InheritedChatTheme.of(context)
                    .theme
                    .videoTrackBackgroundColor,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: _background.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 3.0),
                    child: Text(
                      VideoMessage.durationFormat.format(
                        DateTime.fromMillisecondsSinceEpoch(
                          _controller.value.isPlaying
                              ? (_controller.value.duration.inMilliseconds -
                                  _controller.value.position.inMilliseconds)
                              : _controller.value.duration.inMilliseconds,
                        ),
                      ),
                      style: InheritedChatTheme.of(context)
                          .theme
                          .caption
                          .copyWith(color: _foreground),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: _togglePlaying,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }

    /*Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            tooltip: _videoPlayer.value.isPlaying
                ? InheritedL10n.of(context).l10n.pauseButtonAccessibilityLabel
                : InheritedL10n.of(context).l10n.playButtonAccessibilityLabel,
            padding: EdgeInsets.zero,
            onPressed: _videoPlayerReady ? _togglePlaying : null,
            icon: _videoPlayer.value.isPlaying
                ? (InheritedChatTheme.of(context).theme.pauseButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.pauseButtonIcon!,
                        color: _color,
                      )
                    : Icon(
                        Icons.pause_circle_filled,
                        color: _color,
                        size: 44,
                      ))
                : (InheritedChatTheme.of(context).theme.playButtonIcon != null
                    ? Image.asset(
                        InheritedChatTheme.of(context).theme.playButtonIcon!,
                        color: _color,
                      )
                    : Icon(
                        Icons.play_circle_fill,
                        color: _color,
                        size: 44,
                      )),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: widget.messageWidth.toDouble(),
                    height: 20,
                    child: _videoPlayer.isPlaying || _videoPlayer.isPaused
                        ? StreamBuilder<PlaybackDisposition>(
                            stream: _videoPlayer.onProgress,
                            builder: (context, snapshot) {
                              return WaveForm(
                                accessibilityLabel: InheritedL10n.of(context)
                                    .l10n
                                    .videoTrackAccessibilityLabel,
                                onTap: _togglePlaying,
                                onStartSeeking: () async {
                                  _wasPlayingBeforeSeeking =
                                      _videoPlayer.isPlaying;
                                  if (_videoPlayer.isPlaying) {
                                    await _videoPlayer.pausePlayer();
                                  }
                                },
                                onSeek: snapshot.hasData
                                    ? (newPosition) async {
                                        print(newPosition.toString());
                                        await _videoPlayer
                                            .seekToPlayer(newPosition);
                                        if (_wasPlayingBeforeSeeking) {
                                          await _videoPlayer.resumePlayer();
                                          _wasPlayingBeforeSeeking = false;
                                        }
                                      }
                                    : null,
                                waveForm: widget.message.waveForm,
                                color: _user.id == widget.message.authorId
                                    ? InheritedChatTheme.of(context)
                                        .theme
                                        .primaryTextColor
                                    : InheritedChatTheme.of(context)
                                        .theme
                                        .secondaryTextColor,
                                duration: snapshot.hasData
                                    ? snapshot.data!.duration
                                    : widget.message.length,
                                position: snapshot.hasData
                                    ? snapshot.data!.position
                                    : const Duration(),
                              );
                            })
                        : WaveForm(
                            accessibilityLabel: InheritedL10n.of(context)
                                .l10n
                                .videoTrackAccessibilityLabel,
                            onTap: _togglePlaying,
                            waveForm: widget.message.waveForm,
                            color: _user.id == widget.message.authorId
                                ? InheritedChatTheme.of(context)
                                    .theme
                                    .primaryTextColor
                                : InheritedChatTheme.of(context)
                                    .theme
                                    .secondaryTextColor,
                            duration: widget.message.length,
                            position: const Duration(),
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (_videoPlayer.isPlaying || _videoPlayer.isPaused)
                    StreamBuilder<PlaybackDisposition>(
                        stream: _videoPlayer.onProgress,
                        builder: (context, snapshot) {
                          return Text(
                            VideoMessage.durationFormat.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                snapshot.hasData
                                    ? snapshot.data!.duration.inMilliseconds -
                                        snapshot.data!.position.inMilliseconds
                                    : widget.message.length.inMilliseconds,
                              ),
                            ),
                            style: InheritedChatTheme.of(context)
                                .theme
                                .caption
                                .copyWith(
                                  color: _user.id == widget.message.authorId
                                      ? InheritedChatTheme.of(context)
                                          .theme
                                          .primaryTextColor
                                      : InheritedChatTheme.of(context)
                                          .theme
                                          .secondaryTextColor,
                                ),
                            textWidthBasis: TextWidthBasis.longestLine,
                          );
                        })
                  else
                    Text(
                      VideoMessage.durationFormat.format(
                        DateTime.fromMillisecondsSinceEpoch(
                          widget.message.length.inMilliseconds,
                        ),
                      ),
                      style:
                          InheritedChatTheme.of(context).theme.caption.copyWith(
                                color: _user.id == widget.message.authorId
                                    ? InheritedChatTheme.of(context)
                                        .theme
                                        .primaryTextColor
                                    : InheritedChatTheme.of(context)
                                        .theme
                                        .secondaryTextColor,
                              ),
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    )*/
    ;
  }
}
