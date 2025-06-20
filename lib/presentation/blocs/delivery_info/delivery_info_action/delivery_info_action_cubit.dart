import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delivery_info_action_state.dart';

class DeliveryInfoActionCubit extends Cubit<DeliveryInfoActionState> {
  DeliveryInfoActionCubit() : super(DeliveryInfoActionInitial());
}
