import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_dimensions.dart';
import '../../../theme/consts.dart';
import '../../../utils/enums/context_extension.dart';
import '../../../widgets/custom_list_tile.dart';
import 'expansion_panel_item.dart';

class DictionaryContainer extends HookWidget {
  const DictionaryContainer({
    Key? key,
    this.definition,
    required this.actualIndex,
    required this.listLength,
    this.partOfSpeech,
    this.synonyms,
    this.typeOf,
    this.examples,
  }) : super(key: key);

  final String? definition;
  final String? partOfSpeech;
  final List<String>? synonyms;
  final List<String>? typeOf;
  final List<String>? examples;
  final int actualIndex;
  final int listLength;

  @override
  Widget build(BuildContext context) {
    final expansionPanelItems = useState([
      ExpansionPanelItem(
        header: context.tr.wordDefinition,
        param: definition,
        isExpanded: true,
      ),
      ExpansionPanelItem(
        header: context.tr.partOfSpeech,
        param: partOfSpeech,
      ),
      ExpansionPanelItem(
        paramList: synonyms,
        header: '${context.tr.synonyms}: (${synonyms?.length ?? 0})',
      ),
      ExpansionPanelItem(
        paramList: typeOf,
        header: '${context.tr.typeOf}: (${typeOf?.length ?? 0})',
      ),
      ExpansionPanelItem(
        paramList: examples,
        header: '${context.tr.examples}: (${examples?.length ?? 0})',
      ),
    ]);
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppDimensions.d6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${context.tr.wordDefinition} $actualIndex/$listLength:",
                style: context.tht.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: context.mqs.height * 0.01,
          ),
          Container(
            padding: EdgeInsets.all(
              context.mqs.height * 0.01,
            ),
            constraints: BoxConstraints(
              minHeight: context.mqs.height * 0.1,
            ),
            width: context.mqs.width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.whiteSmoke,
              border: Border.all(
                color: AppColors.daintree,
              ),
              borderRadius: BorderRadius.circular(
                AppDimensions.d16,
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.daintree,
                  offset: Offset.zero,
                  blurRadius: AppDimensions.d4,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: ExpansionPanelList(
              elevation: AppConst.staticZero,
              dividerColor: AppColors.daintree,
              expansionCallback: (index, isExpanded) {
                expansionPanelItems.value[index] = ExpansionPanelItem(
                  param: expansionPanelItems.value[index].param,
                  paramList: expansionPanelItems.value[index].paramList,
                  header: expansionPanelItems.value[index].header,
                  isExpanded: !isExpanded,
                );
                expansionPanelItems.value = [...expansionPanelItems.value];
              },
              children: expansionPanelItems.value
                  .map<ExpansionPanel>(
                    (item) => ExpansionPanel(
                      backgroundColor: AppColors.whiteSmoke,
                      canTapOnHeader: true,
                      isExpanded: item.isExpanded,
                      headerBuilder: (context, isExpanded) => CustomListTile(
                        withDivider: false,
                        title: Text(
                          item.header,
                          style: context.tht.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: context.mqs.width * 0.14,
                        ),
                      ),
                      body: Column(
                        children: item.paramList != null
                            ? item.paramList!
                                .map<Widget>(
                                  (e) => CustomListTile(
                                    title: Row(
                                      children: [
                                        Text('${item.paramList!.indexOf(e) + 1}.'),
                                        const Spacer(),
                                        Text(e),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()
                            : [
                                item.param != null
                                    ? CustomListTile(
                                        title: Text(
                                          item.param ?? '',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
