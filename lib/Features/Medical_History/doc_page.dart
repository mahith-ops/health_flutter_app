import 'package:flutter/material.dart';
import 'package:hello_flutter/components/card/card.dart' as custom;
import 'package:hello_flutter/components/switch/switch.dart' as custom_switch;
import 'package:hello_flutter/components/text-area/text_area.dart';

/// Doctor Details Screen
/// Displays comprehensive information about a doctor including:
/// - Profile with avatar and verification badge
/// - Next appointment details
/// - Medical history access (reports and consultations)
/// - Personal notes
/// - Last visit information
class DoctorDetailsScreen extends StatefulWidget {
  const DoctorDetailsScreen({super.key});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  // Sample data - replace with actual data from your data model
  final String doctorName = 'Dr. Sarah Johnson';
  final String specialty = 'Cardiology';
  final String nextAppointmentDate = 'Mar 15, 2026';
  final String nextAppointmentTime = '10:00 AM';
  final String lastVisitDate = 'Dec 15, 2025';
  bool _remindMeEnabled = true;
  String _personalNotes = '';
  bool _isEditingNotes = false;

  void _handleEdit() {
    // TODO: Navigate to edit screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon')),
    );
  }

  void _handleAddAppointment() {
    // TODO: Navigate to add appointment screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add appointment functionality coming soon')),
    );
  }

  void _handleShowReports() {
    // TODO: Navigate to reports screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Show reports functionality coming soon')),
    );
  }

  void _handlePastConsultations() {
    // TODO: Navigate to past consultations screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Past consultations functionality coming soon')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              _buildDoctorProfile(),
              const SizedBox(height: 32),
              _buildNextAppointmentCard(),
              const SizedBox(height: 16),
              _buildShowReportsCard(),
              const SizedBox(height: 16),
              _buildPastConsultationsCard(),
              const SizedBox(height: 24),
              _buildPersonalNotesSection(),
              const SizedBox(height: 24),
              _buildLastVisitCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
      ),
      title: const Text(
        'Doctor Details',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: _handleEdit,
          child: const Text(
            'Edit',
            style: TextStyle(
              color: Color(0xFF4DB6AC), // Teal color
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorProfile() {
    return Column(
      children: [
        // Avatar with verification badge
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF4DB6AC), // Teal background
              ),
              child: const Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            // Verification badge
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          doctorName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          specialty,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4DB6AC), // Teal color
          ),
        ),
      ],
    );
  }

  Widget _buildNextAppointmentCard() {
    return custom.Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'NEXT APPOINTMENT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _handleAddAppointment,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Color(0xFF4DB6AC), // Teal color
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            nextAppointmentDate,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            nextAppointmentTime,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    size: 18,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Remind me',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              custom_switch.Switch(
                value: _remindMeEnabled,
                onChanged: (value) {
                  setState(() {
                    _remindMeEnabled = value;
                  });
                },
                activeColor: const Color(0xFF4DB6AC), // Teal color
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShowReportsCard() {
    return custom.Card(
      onTap: _handleShowReports,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.description,
              color: Colors.green,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Show Reports',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View chronological history',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildPastConsultationsCard() {
    return custom.Card(
      onTap: _handlePastConsultations,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.calendar_today,
              color: Colors.purple,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Past Consultations',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'View consultation history',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Personal Notes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  _isEditingNotes = !_isEditingNotes;
                });
              },
              icon: Icon(
                Icons.edit,
                size: 16,
                color: Colors.grey[600],
              ),
              label: Text(
                _isEditingNotes ? 'Done' : 'Edit',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _isEditingNotes
            ? TextArea(
                label: null,
                hint: 'No notes added yet',
                value: _personalNotes.isEmpty ? null : _personalNotes,
                onChanged: (value) {
                  setState(() {
                    _personalNotes = value;
                  });
                },
                minLines: 3,
                maxLines: 5,
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _personalNotes.isEmpty ? 'No notes added yet' : _personalNotes,
                  style: TextStyle(
                    fontSize: 14,
                    color: _personalNotes.isEmpty ? Colors.grey[400] : Colors.black87,
                    fontStyle: _personalNotes.isEmpty ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildLastVisitCard() {
    return custom.Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Last Visit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lastVisitDate,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
