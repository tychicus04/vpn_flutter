import 'package:shared_value/shared_value.dart';

final SharedValue<bool> show_dialog = SharedValue(
  // initial value
  value: false,
  key: "show_dialog",
  autosave: true,
);

final SharedValue<String> hash_code = SharedValue(
  // initial value
  value: "",
  key: "hash_code",
  autosave: true,
);

final SharedValue<String> url = SharedValue(
  // initial value
  value: "",
  key: "url",
  autosave: true,
);

final SharedValue<String> session_id = SharedValue(
  // initial value
  value: "",
  key: "session_id",
  autosave: true,
);

final SharedValue<bool> check = SharedValue(
  // initial value
  value: false,
  key: "check",
  autosave: true,
);
