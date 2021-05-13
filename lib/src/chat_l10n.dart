import 'package:flutter/material.dart';

/// Base chat l10n containing all required variables to provide localized copy.
/// Extend this class if you want to create a custom l10n.
@immutable
abstract class ChatL10n {
  /// Creates a new chat l10n based on provided copy
  const ChatL10n({
    required this.attachmentButtonAccessibilityLabel,
    required this.emptyChatPlaceholder,
    required this.fileButtonAccessibilityLabel,
    required this.inputPlaceholder,
    required this.sendButtonAccessibilityLabel,
    required this.audioButtonAccessibilityLabel,
    required this.today,
    required this.yesterday,
    required this.playButtonAccessibilityLabel,
    required this.pauseButtonAccessibilityLabel,
    required this.audioTrackAccessibilityLabel,
    required this.videoButtonAccessibilityLabel,
    required this.videoPlayerAccessibilityLabel,
    required this.noCameraAvailableMessage,
    required this.cancelVideoRecordingButton,
    required this.videoRecordingSwitchCamera,
  });

  /// Accessibility label (hint) for the attachment button
  final String attachmentButtonAccessibilityLabel;

  /// Placeholder when there are no messages
  final String emptyChatPlaceholder;

  /// Accessibility label (hint) for the tap action on file message
  final String fileButtonAccessibilityLabel;

  /// Accessibility label (hint) for the tap action on audio message when playing
  final String pauseButtonAccessibilityLabel;

  /// Accessibility label (hint) for the tap action on audio message when not playing
  final String playButtonAccessibilityLabel;

  /// Placeholder for the text field
  final String inputPlaceholder;

  /// Accessibility label (hint) for the send button
  final String sendButtonAccessibilityLabel;

  /// Accessibility label (hint) for the audio button
  final String audioButtonAccessibilityLabel;

  /// Today string
  final String today;

  /// Yesterday string
  final String yesterday;

  /// Accessibility label (hint) for the audio track
  final String audioTrackAccessibilityLabel;

  /// Accessibility label (hint) for the video player in video message
  final String videoPlayerAccessibilityLabel;

  /// Accessibility label (hint) for the video button
  final String videoButtonAccessibilityLabel;

  /// Message that appears in camera recorder when no camera is available
  final String noCameraAvailableMessage;

  /// Button to cancel recording of a video message
  final String cancelVideoRecordingButton;

  /// Tooltip/hint for the button to switch between cameras (front/back) in video recording UI
  final String videoRecordingSwitchCamera;
}

/// English l10n which extends [ChatL10n]
@immutable
class ChatL10nEn extends ChatL10n {
  /// Creates English l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEn({
    String attachmentButtonAccessibilityLabel = 'Send media',
    String emptyChatPlaceholder = 'No messages here yet',
    String fileButtonAccessibilityLabel = 'File',
    String inputPlaceholder = 'Message',
    String sendButtonAccessibilityLabel = 'Send',
    String today = 'Today',
    String yesterday = 'Yesterday',
    String audioButtonAccessibilityLabel = 'Record audio message',
    String playButtonAccessibilityLabel = 'Play',
    String pauseButtonAccessibilityLabel = 'Pause',
    String audioTrackAccessibilityLabel = 'Tap to play/pause, slide to seek',
    String videoButtonAccessibilityLabel = 'Record video message',
    String videoPlayerAccessibilityLabel = 'Play/Pause',
    String noCameraAvailableMessage = 'No camera available',
    String cancelVideoRecordingButton = 'Cancel',
    String videoRecordingSwitchCamera = 'Switch camera',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
          audioButtonAccessibilityLabel: audioButtonAccessibilityLabel,
          playButtonAccessibilityLabel: playButtonAccessibilityLabel,
          pauseButtonAccessibilityLabel: pauseButtonAccessibilityLabel,
          audioTrackAccessibilityLabel: audioTrackAccessibilityLabel,
          videoButtonAccessibilityLabel: videoButtonAccessibilityLabel,
          videoPlayerAccessibilityLabel: videoPlayerAccessibilityLabel,
          noCameraAvailableMessage: noCameraAvailableMessage,
          cancelVideoRecordingButton: cancelVideoRecordingButton,
          videoRecordingSwitchCamera: videoRecordingSwitchCamera,
        );
}

/// Spanish l10n which extends [ChatL10n]
@immutable
class ChatL10nEs extends ChatL10n {
  /// Creates Spanish l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nEs({
    String attachmentButtonAccessibilityLabel = 'Enviar multimedia',
    String emptyChatPlaceholder = 'Aún no hay mensajes',
    String fileButtonAccessibilityLabel = 'Archivo',
    String inputPlaceholder = 'Mensaje',
    String sendButtonAccessibilityLabel = 'Enviar',
    String today = 'Hoy',
    String yesterday = 'Ayer',
    String audioButtonAccessibilityLabel = 'Grabar mensaje de audio',
    String playButtonAccessibilityLabel = 'Reproducir',
    String pauseButtonAccessibilityLabel = 'Pausar',
    String audioTrackAccessibilityLabel =
        'Toca para reproducir/pausar, desliza para buscar',
    String videoButtonAccessibilityLabel = 'Grabar mensaje de video',
    String videoPlayerAccessibilityLabel = 'Reproducir/Pausar',
    String noCameraAvailableMessage = 'No hay cámara disponible',
    String cancelVideoRecordingButton = 'Cancelar',
    String videoRecordingSwitchCamera = 'Cambiar de cámara',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
          audioButtonAccessibilityLabel: audioButtonAccessibilityLabel,
          playButtonAccessibilityLabel: playButtonAccessibilityLabel,
          pauseButtonAccessibilityLabel: pauseButtonAccessibilityLabel,
          audioTrackAccessibilityLabel: audioTrackAccessibilityLabel,
          videoButtonAccessibilityLabel: videoButtonAccessibilityLabel,
          videoPlayerAccessibilityLabel: videoPlayerAccessibilityLabel,
          noCameraAvailableMessage: noCameraAvailableMessage,
          cancelVideoRecordingButton: cancelVideoRecordingButton,
          videoRecordingSwitchCamera: videoRecordingSwitchCamera,
        );
}

/// Polish l10n which extends [ChatL10n]
@immutable
class ChatL10nPl extends ChatL10n {
  /// Creates Polish l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nPl({
    String attachmentButtonAccessibilityLabel = 'Wyślij multimedia',
    String emptyChatPlaceholder = 'Tu jeszcze nie ma wiadomości',
    String fileButtonAccessibilityLabel = 'Plik',
    String inputPlaceholder = 'Napisz wiadomość',
    String sendButtonAccessibilityLabel = 'Wyślij',
    String today = 'Dzisiaj',
    String yesterday = 'Wczoraj',
    String audioButtonAccessibilityLabel = 'Nagraj wiadomość dźwiękową',
    String playButtonAccessibilityLabel = 'Odtwórz',
    String pauseButtonAccessibilityLabel = 'Wstrzymać',
    String audioTrackAccessibilityLabel =
        'Dotknij, aby odtworzyć/wstrzymać, przesuń, aby wyszukać',
    String videoButtonAccessibilityLabel = 'Nagraj wiadomość wideo',
    String videoPlayerAccessibilityLabel = 'Odtwórz/Wstrzymać',
    String noCameraAvailableMessage = 'Brak dostępnej kamery',
    String cancelVideoRecordingButton = 'Anuluj',
    String videoRecordingSwitchCamera = 'Przełącz aparat',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
          audioButtonAccessibilityLabel: audioButtonAccessibilityLabel,
          playButtonAccessibilityLabel: playButtonAccessibilityLabel,
          pauseButtonAccessibilityLabel: pauseButtonAccessibilityLabel,
          audioTrackAccessibilityLabel: audioTrackAccessibilityLabel,
          videoButtonAccessibilityLabel: videoButtonAccessibilityLabel,
          videoPlayerAccessibilityLabel: videoPlayerAccessibilityLabel,
          noCameraAvailableMessage: noCameraAvailableMessage,
          cancelVideoRecordingButton: cancelVideoRecordingButton,
          videoRecordingSwitchCamera: videoRecordingSwitchCamera,
        );
}

/// Russian l10n which extends [ChatL10n]
@immutable
class ChatL10nRu extends ChatL10n {
  /// Creates Russian l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nRu({
    String attachmentButtonAccessibilityLabel = 'Отправить медиа',
    String emptyChatPlaceholder = 'Пока что у вас нет сообщений',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Сообщение',
    String sendButtonAccessibilityLabel = 'Отправить',
    String today = 'Сегодня',
    String yesterday = 'Вчера',
    String audioButtonAccessibilityLabel = 'Записать звуковое сообщение',
    String playButtonAccessibilityLabel = 'Воспроизвести',
    String pauseButtonAccessibilityLabel = 'Приостановить',
    String audioTrackAccessibilityLabel =
        'Нажмите для воспроизведения / паузы, проведите пальцем для поиска',
    String videoButtonAccessibilityLabel = 'Записать видео сообщение',
    String videoPlayerAccessibilityLabel = 'Воспроизвести/Приостановить',
    String noCameraAvailableMessage = 'Камера недоступна',
    String cancelVideoRecordingButton = 'Отмена',
    String videoRecordingSwitchCamera = 'Переключить камеру',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
          audioButtonAccessibilityLabel: audioButtonAccessibilityLabel,
          playButtonAccessibilityLabel: playButtonAccessibilityLabel,
          pauseButtonAccessibilityLabel: pauseButtonAccessibilityLabel,
          audioTrackAccessibilityLabel: audioTrackAccessibilityLabel,
          videoButtonAccessibilityLabel: videoButtonAccessibilityLabel,
          videoPlayerAccessibilityLabel: videoPlayerAccessibilityLabel,
          noCameraAvailableMessage: noCameraAvailableMessage,
          cancelVideoRecordingButton: cancelVideoRecordingButton,
          videoRecordingSwitchCamera: videoRecordingSwitchCamera,
        );
}

/// Ukrainian l10n which extends [ChatL10n]
@immutable
class ChatL10nUk extends ChatL10n {
  /// Creates Ukrainian l10n. Use this constructor if you want to
  /// override only a couple of variables, otherwise create a new class
  /// which extends [ChatL10n]
  const ChatL10nUk({
    String attachmentButtonAccessibilityLabel = 'Надіслати медіа',
    String emptyChatPlaceholder = 'Повідомлень ще немає',
    String fileButtonAccessibilityLabel = 'Файл',
    String inputPlaceholder = 'Повідомлення',
    String sendButtonAccessibilityLabel = 'Надіслати',
    String today = 'Сьогодні',
    String yesterday = 'Учора',
    String audioButtonAccessibilityLabel = 'Записати звукове повідомлення',
    String playButtonAccessibilityLabel = 'Відтворіть',
    String pauseButtonAccessibilityLabel = 'Призупиніть',
    String audioTrackAccessibilityLabel =
        'Натисніть, щоб відтворити / призупинити, проведіть пальцем, щоб шукати',
    String videoButtonAccessibilityLabel = 'Записати відео-повідомлення',
    String videoPlayerAccessibilityLabel = 'відтворити / призупинити',
    String noCameraAvailableMessage = 'Немає доступної камери',
    String cancelVideoRecordingButton = 'Скасувати',
    String videoRecordingSwitchCamera = 'Переключити камеру',
  }) : super(
          attachmentButtonAccessibilityLabel:
              attachmentButtonAccessibilityLabel,
          emptyChatPlaceholder: emptyChatPlaceholder,
          fileButtonAccessibilityLabel: fileButtonAccessibilityLabel,
          inputPlaceholder: inputPlaceholder,
          sendButtonAccessibilityLabel: sendButtonAccessibilityLabel,
          today: today,
          yesterday: yesterday,
          audioButtonAccessibilityLabel: audioButtonAccessibilityLabel,
          playButtonAccessibilityLabel: playButtonAccessibilityLabel,
          pauseButtonAccessibilityLabel: pauseButtonAccessibilityLabel,
          audioTrackAccessibilityLabel: audioTrackAccessibilityLabel,
          videoButtonAccessibilityLabel: videoButtonAccessibilityLabel,
          videoPlayerAccessibilityLabel: videoPlayerAccessibilityLabel,
          noCameraAvailableMessage: noCameraAvailableMessage,
          cancelVideoRecordingButton: cancelVideoRecordingButton,
          videoRecordingSwitchCamera: videoRecordingSwitchCamera,
        );
}
