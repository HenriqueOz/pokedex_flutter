import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_app/app/core/formatter/formatter.dart';
import 'package:pokedex_app/app/core/ui/custom_theme.dart';
import 'package:pokedex_app/app/core/ui/messenger.dart';

class TabDescription extends StatelessWidget {
  final Map<String, dynamic> description;
  final Map<String, String?> cries;
  final List<String> keys = ['height', 'weight', 'base_happiness', 'capture_rate', 'pokedex_entry'];

  final Color primaryColor;
  final Color secondaryColor;

  final _audioPlayer = AudioPlayer();

  TabDescription({super.key, required this.description, required this.cries, required this.primaryColor, required this.secondaryColor});

  Future<void> playAudioFromUrl(String url) async {
    if (_audioPlayer.state == PlayerState.playing) {
      await _audioPlayer.stop();
    }

    await _audioPlayer.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    final double? height = description[keys[0]] / 10;
    final double? weight = description[keys[1]] / 10;
    final int baseHappiness = description[keys[2]] ?? 0;
    final int captureRate = description[keys[3]] ?? 0;
    final String entry = description[keys[4]] ?? 'Undefined';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          //* Entry section
          Row(
            children: [
              Text(
                'Pokedex Entry',
                style: CustomTheme.pokedexLabels.copyWith(
                  color: primaryColor,
                ),
              ),
              IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: entry));
                  Messenger.of(context).showMessage('Copied Successfully', Colors.white, primaryColor);
                },
                icon: Icon(
                  Icons.copy,
                  color: primaryColor,
                  size: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Text(
            entry,
            textAlign: TextAlign.left,
            style: CustomTheme.body.copyWith(
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            () {
              final splited = description['generation'].split('-');
              return '${Formatter.captalize(text: splited[0])} ${splited[1].toUpperCase()}';
            }(),
          ),
          //* Details section
          Divider(
            height: 40,
            color: primaryColor,
            thickness: .5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _descriptionInfo("Height:", 'm', height, primaryColor),
              _descriptionInfo("Weight:", 'Kg', weight, primaryColor),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _descriptionInfo("Base Happiness:", '', baseHappiness, primaryColor),
              _descriptionInfo("Capture Rate:", '', captureRate, primaryColor),
            ],
          ),
          Divider(
            height: 40,
            color: primaryColor,
            thickness: .5,
          ),
          //* Cries section
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Crie(s)',
              textAlign: TextAlign.left,
              style: CustomTheme.pokedexLabels.copyWith(
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              _audioButton(
                primaryColor: primaryColor,
                label: 'Latest',
                audioUrl: cries['latest'] ?? '',
              ),
              const SizedBox(width: 20),
              () {
                String? legacyUrl = cries['legacy'];
                if (legacyUrl != null) {
                  return _audioButton(
                    primaryColor: primaryColor,
                    label: 'Legacy',
                    audioUrl: legacyUrl,
                  );
                }
                return const SizedBox.shrink();
              }(),
            ],
          )
        ],
      ),
    );
  }

  Widget _audioButton({required Color primaryColor, required String label, required String audioUrl}) {
    return IconButton(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: () async {
        await playAudioFromUrl(audioUrl);
      },
      icon: Row(
        children: [
          Icon(
            Icons.volume_up,
            color: primaryColor,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            label,
          ),
        ],
      ),
    );
  }

  Widget _descriptionInfo(String label, String unit, num? info, Color primaryColor) {
    return Row(
      children: [
        Text(
          label,
          style: CustomTheme.pokedexLabels.copyWith(color: primaryColor, fontSize: 14),
        ),
        const SizedBox(width: 10),
        Text('$info $unit'),
      ],
    );
  }
}
