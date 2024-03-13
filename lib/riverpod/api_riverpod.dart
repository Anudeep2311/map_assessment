import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:map_assessment/api/api.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
