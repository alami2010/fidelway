import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../shared/constant.dart';

class RewardPreviewDialog extends StatelessWidget {
  final List<Map<String, dynamic>> choices;

  const RewardPreviewDialog({
    Key? key,
    required this.choices,
  }) : super(key: key);

  /// Show reward preview in a dialog popup
  static void show(BuildContext context, List<Map<String, dynamic>> choices) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RewardPreviewDialog(choices: choices);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final previews = _generateRewardPreviews(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kMainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.rewardPreview,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Preview content
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: _buildRewardPreview(context, previews),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Generate reward preview messages based on configured rewards
  List<String> _generateRewardPreviews(BuildContext context) {
    if (choices.isEmpty) {
      return [];
    }

    List<String> previews = [];

    // Sort rewards by points to show them in ascending order
    List<Map<String, dynamic>> sortedChoices = List.from(choices);
    sortedChoices
        .sort((a, b) => (a["points"] as int).compareTo(b["points"] as int));

    for (int i = 0; i < sortedChoices.length; i++) {
      final choice = sortedChoices[i];
      final points = choice["points"] as int;
      final rewardName = getLocalizedChoiceName(context, choice);

      // Determine order number (10th, 20th, etc.)
      final orderNumber = ((i + 1) * 10).toString();

      // Extract percentage or amount from reward name
      String previewMessage = "";

      if (rewardName.toLowerCase().contains("%") ||
          rewardName.toLowerCase().contains("discount") ||
          rewardName.toLowerCase().contains("réduction")) {
        // Extract percentage
        RegExp percentageRegex = RegExp(r'(\d+)%');
        Match? match = percentageRegex.firstMatch(rewardName);
        if (match != null) {
          String percentage = match.group(1)!;
          previewMessage = AppLocalizations.of(context)!
                  .atPointsYouBenefitFrom(points.toString()) +
              " " +
              AppLocalizations.of(context)!
                  .discountOnYourOrder(percentage, orderNumber);
        } else {
          // Default to 10% if no percentage found
          previewMessage = AppLocalizations.of(context)!
                  .atPointsYouBenefitFrom(points.toString()) +
              " " +
              AppLocalizations.of(context)!
                  .discountOnYourOrder("10", orderNumber);
        }
      } else if (rewardName.toLowerCase().contains("€") ||
          rewardName.toLowerCase().contains("euro")) {
        // Extract amount
        RegExp amountRegex = RegExp(r'(\d+)\s*€?');
        Match? match = amountRegex.firstMatch(rewardName);
        String amount = match != null ? match.group(1)! : "10";

        // For voucher, fix the grammatical issue by replacing "d'une" with "d'un bon de"
        final baseText = AppLocalizations.of(context)!
            .atPointsYouBenefitFrom(points.toString());
        previewMessage = baseText.replaceAll("d'une",
            "d'un bon de ${amount}€ valable sur votre ${orderNumber}ᵉ commande");
      } else {
        // Generic reward description
        previewMessage =
            "${AppLocalizations.of(context)!.atPointsYouBenefitFrom(points.toString())} ${rewardName.toLowerCase()}";
      }

      previews.add(previewMessage);
    }

    return previews;
  }

  /// Build reward preview section
  Widget _buildRewardPreview(BuildContext context, List<String> previews) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: previews.isEmpty ? Colors.blue.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              previews.isEmpty ? Colors.blue.shade200 : Colors.green.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (previews.isEmpty ? Colors.blue : Colors.green)
                .withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                previews.isEmpty ? Icons.info_outline : Icons.card_giftcard,
                color: previews.isEmpty
                    ? Colors.blue.shade600
                    : Colors.green.shade600,
                size: 28,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.rewardPreview,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: previews.isEmpty
                            ? Colors.blue.shade800
                            : Colors.green.shade800,
                      ),
                    ),
                    if (previews.isNotEmpty) ...[
                      SizedBox(height: 4),
                      Text(
                        AppLocalizations.of(context)!.whatYouCanEarn,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (previews.isEmpty)
            Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.noRewardsAvailable,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.configureRewardsToSeePreview,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // Show example format
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue.shade300),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: Colors.blue.shade600, size: 20),
                          SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.exampleRewards,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      _buildExamplePreviewItem(
                          context, "100", "10", "10", true),
                      SizedBox(height: 8),
                      _buildExamplePreviewItem(
                          context, "100", "10", "10", false),
                      SizedBox(height: 8),
                      _buildExamplePreviewItem(
                          context, "200", "10", "20", true),
                    ],
                  ),
                ),
              ],
            )
          else
            ...previews
                .map((preview) => Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.only(top: 6, right: 12),
                            decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              preview,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.green.shade900,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
        ],
      ),
    );
  }

  /// Build example preview item for empty state
  Widget _buildExamplePreviewItem(BuildContext context, String points,
      String value, String orderNumber, bool isDiscount) {
    final loc = AppLocalizations.of(context)!;

    String text;
    if (isDiscount) {
      // For discount: "À {points} points, vous bénéficiez d'une remise de {discount}% sur votre {orderNumber}ᵉ commande"
      text = loc.atPointsYouBenefitFrom(points) +
          " " +
          loc.discountOnYourOrder(value, orderNumber);
    } else {
      // For voucher: "À {points} points, vous bénéficiez d'un bon de {amount}€ valable sur votre {orderNumber}ᵉ commande"
      // Replace "d'une" with "d'un bon de" to fix the grammatical issue
      final baseText = loc.atPointsYouBenefitFrom(points);
      text = baseText.replaceAll("d'une",
          "d'un bon de ${value}€ valable sur votre ${orderNumber}ᵉ commande");
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 6,
          height: 6,
          margin: EdgeInsets.only(top: 6, right: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade600,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
