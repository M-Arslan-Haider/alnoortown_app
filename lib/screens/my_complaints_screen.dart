import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../core/app_colors.dart';
import '../core/app_widgets.dart';

class MyComplaintsScreen extends StatefulWidget {
  const MyComplaintsScreen({super.key});

  @override
  State<MyComplaintsScreen> createState() => _MyComplaintsScreenState();
}

class _MyComplaintsScreenState extends State<MyComplaintsScreen> {
  List<dynamic> _complaints = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchComplaints();
  }

  Future<void> _fetchComplaints() async {
    setState(() { _loading = true; _error = null; });
    try {
      // 🔧 Replace with your real endpoint + auth headers
      final response = await http.get(
        Uri.parse('https://your-api.com/api/complaints/my'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Adjust key based on your API response shape
        setState(() {
          _complaints = data['complaints'] ?? data ?? [];
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Server error: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to connect. Check your internet.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: GoldAppBar(title: 'My Complaints'),
      body: RefreshIndicator(
        color: AppColors.gold,
        onRefresh: _fetchComplaints,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.gold),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_outlined,
                  size: 48, color: AppColors.grey),
              const SizedBox(height: 16),
              Text(_error!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Cormorant',
                      fontSize: 15,
                      color: AppColors.grey)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchComplaints,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: const Text('Retry',
                    style: TextStyle(
                        fontFamily: 'Cormorant',
                        color: AppColors.white,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
      );
    }

    if (_complaints.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined, size: 56, color: AppColors.greyLight),
            const SizedBox(height: 12),
            const Text('No complaints yet',
                style: TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 16,
                    color: AppColors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: _complaints.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, i) => _ComplaintCard(data: _complaints[i]),
    );
  }
}

// ═══════════════════════════════════════
//  COMPLAINT CARD
// ═══════════════════════════════════════
class _ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _ComplaintCard({required this.data});

  Color _statusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'resolved': return Colors.green;
      case 'in progress': return Colors.orange;
      case 'rejected': return AppColors.error;
      default: return AppColors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = data['status'] as String?;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data['title'] ?? 'Untitled',
                  style: const TextStyle(
                      fontFamily: 'Cormorant',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.charcoal),
                ),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _statusColor(status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status ?? 'Pending',
                  style: TextStyle(
                      fontFamily: 'Cormorant',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: _statusColor(status)),
                ),
              ),
            ],
          ),
          if (data['description'] != null) ...[
            const SizedBox(height: 6),
            Text(
              data['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: 'Cormorant',
                  fontSize: 13,
                  color: AppColors.grey),
            ),
          ],
          if (data['created_at'] != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined,
                    size: 12, color: AppColors.greyLight),
                const SizedBox(width: 4),
                Text(
                  data['created_at'],
                  style: const TextStyle(
                      fontFamily: 'Cormorant',
                      fontSize: 12,
                      color: AppColors.greyLight),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}