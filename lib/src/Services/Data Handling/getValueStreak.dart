import 'package:provider/provider.dart';
import 'package:workout_app/src/Services/Others/dataProvider.dart';

getValue(context, int index) async {
  Future.delayed(Duration.zero, () {
    Provider.of<dataProvider>(context, listen: false).ExtraDataRank(index);
  });
}
