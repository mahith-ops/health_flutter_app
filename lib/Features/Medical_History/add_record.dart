import 'package:flutter/material.dart';
import 'package:hello_flutter/components/button/button.dart';
import 'package:hello_flutter/components/text-field/text_field.dart' as custom;
import 'package:hello_flutter/components/date-picker/date_picker.dart';
import 'package:hello_flutter/components/dropdown/dropdown.dart';
import 'package:hello_flutter/components/text-area/text_area.dart';
import 'package:hello_flutter/components/switch/switch.dart' as custom_switch;
import 'package:hello_flutter/components/file-upload/file_upload.dart';
import 'package:hello_flutter/components/chip/chip.dart';
import 'package:hello_flutter/components/icon-button/icon_button.dart' as custom_icon;

/// Add Record Screen
/// Allows users to add different types of medical records:
/// - Medication
/// - Prescription
/// - Lab Report
/// - Reminder
/// - Medicine Stock
/// - Appointment
class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  // Record type selection
  RecordType _selectedRecordType = RecordType.medication;

  // Medication form fields
  String _medicationName = '';
  DateTime? _medicationFromDate;
  DateTime? _medicationToDate;
  String? _selectedTiming;
  String? _selectedFrequency;
  String _medicineType = '';
  String _dosage = '';
  String _medicationNotes = '';

  // Prescription form fields
  String? _selectedCategory;
  String? _selectedDoctor;
  DateTime? _prescriptionVisitDate;
  String _prescriptionNotes = '';
  DateTime? _nextAppointmentDate;
  bool _remindMeEnabled = false;

  // Available options
  final List<String> _timingOptions = [
    'Before Breakfast',
    'After Breakfast',
    'Before Lunch',
    'After Lunch',
    'Before Dinner',
    'After Dinner',
  ];

  final List<String> _frequencyOptions = [
    'Daily',
    'Weekly',
    'As needed',
  ];

  final List<DropdownItem<String>> _categoryOptions = [
    DropdownItem(value: 'Cardiology', label: 'Cardiology'),
    DropdownItem(value: 'Dermatology', label: 'Dermatology'),
    DropdownItem(value: 'Neurology', label: 'Neurology'),
    DropdownItem(value: 'Orthopedics', label: 'Orthopedics'),
    DropdownItem(value: 'Pediatrics', label: 'Pediatrics'),
  ];

  final List<DropdownItem<String>> _doctorOptions = [
    DropdownItem(value: 'Dr. Smith', label: 'Dr. Smith'),
    DropdownItem(value: 'Dr. Johnson', label: 'Dr. Johnson'),
    DropdownItem(value: 'Dr. Williams', label: 'Dr. Williams'),
    DropdownItem(value: 'Dr. Brown', label: 'Dr. Brown'),
  ];


  void _handleSaveRecord() {
    // TODO: Implement save logic based on record type
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedRecordType.name} record saved successfully!'),
      ),
    );
    Navigator.of(context).pop();
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRecordTypeSelector(),
                    const SizedBox(height: 24),
                    _buildFormContent(),
                  ],
                ),
              ),
            ),
            _buildSaveButton(),
          ],
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
          child: const Icon(Icons.arrow_back),
        ),
      ),
      title: const Text('Add Record'),
      actions: [
        TextButton(
          onPressed: _handleCancel,
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildRecordTypeSelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRecordTypeButton(
            type: RecordType.prescription,
            label: 'Prescription',
            icon: Icons.description,
          ),
          const SizedBox(width: 8),
          _buildRecordTypeButton(
            type: RecordType.labReport,
            label: 'Lab Report',
            icon: Icons.assignment,
          ),
          const SizedBox(width: 8),
          _buildRecordTypeButton(
            type: RecordType.reminder,
            label: 'Reminder',
            icon: Icons.notifications,
          ),
          const SizedBox(width: 8),
          _buildRecordTypeButton(
            type: RecordType.medicineStock,
            label: 'Medicine Stock',
            icon: Icons.inventory,
          ),
          const SizedBox(width: 8),
          _buildRecordTypeButton(
            type: RecordType.medication,
            label: 'Medication',
            icon: Icons.medication,
          ),
          const SizedBox(width: 8),
          _buildRecordTypeButton(
            type: RecordType.appointment,
            label: 'Appointment',
            icon: Icons.calendar_today,
          ),
        ],
      ),
    );
  }

  Widget _buildRecordTypeButton({
    required RecordType type,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedRecordType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRecordType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[700],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent() {
    switch (_selectedRecordType) {
      case RecordType.medication:
        return _buildMedicationForm();
      case RecordType.prescription:
        return _buildPrescriptionForm();
      case RecordType.labReport:
        return _buildLabReportForm();
      case RecordType.reminder:
        return _buildReminderForm();
      case RecordType.medicineStock:
        return _buildMedicineStockForm();
      case RecordType.appointment:
        return _buildAppointmentForm();
    }
  }

  Widget _buildMedicationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        custom.TextField(
          label: 'Medication Name',
          value: _medicationName.isEmpty ? null : _medicationName,
          onChanged: (value) {
            setState(() {
              _medicationName = value;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DatePicker(
                label: 'From Date',
                selectedDate: _medicationFromDate,
                onDateSelected: (date) {
                  setState(() {
                    _medicationFromDate = date;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DatePicker(
                label: 'To Date',
                selectedDate: _medicationToDate,
                onDateSelected: (date) {
                  setState(() {
                    _medicationToDate = date;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Timing'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _timingOptions.map((timing) {
            final isSelected = _selectedTiming == timing;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedTiming = timing;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  timing,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        _buildSectionTitle('Frequency'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _frequencyOptions.map((frequency) {
            final isSelected = _selectedFrequency == frequency;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFrequency = frequency;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  frequency,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        custom.TextField(
          label: 'Medicine Type',
          value: _medicineType.isEmpty ? null : _medicineType,
          onChanged: (value) {
            setState(() {
              _medicineType = value;
            });
          },
        ),
        const SizedBox(height: 16),
        custom.TextField(
          label: 'Dosage',
          hint: 'e.g., 1, 2',
          value: _dosage.isEmpty ? null : _dosage,
          onChanged: (value) {
            setState(() {
              _dosage = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextArea(
          label: 'Notes (optional)',
          hint: 'Add any notes...',
          value: _medicationNotes.isEmpty ? null : _medicationNotes,
          onChanged: (value) {
            setState(() {
              _medicationNotes = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPrescriptionForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Dropdown<String>(
          label: 'Category',
          hint: 'Type to search or select (e.g. Cardiology)',
          value: _selectedCategory,
          items: _categoryOptions,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () {
            // TODO: Implement add new category
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add new category feature coming soon')),
            );
          },
          child: const Text('+ Add new category'),
        ),
        const SizedBox(height: 16),
        Dropdown<String>(
          label: 'Doctor Name',
          hint: 'Type to search or select (e.g. Dr. Smith)',
          value: _selectedDoctor,
          items: _doctorOptions,
          onChanged: (value) {
            setState(() {
              _selectedDoctor = value;
            });
          },
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () {
            // TODO: Implement add new doctor
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Add new doctor feature coming soon')),
            );
          },
          child: const Text('+ Add new doctor'),
        ),
        const SizedBox(height: 16),
        DatePicker(
          label: 'Date of Visit',
          selectedDate: _prescriptionVisitDate,
          onDateSelected: (date) {
            setState(() {
              _prescriptionVisitDate = date;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Documents'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Icon(Icons.cloud_upload, size: 48, color: Colors.grey[600]),
              const SizedBox(height: 12),
              const Text(
                'Tap to upload',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Prescriptions, Lab Reports, X-Rays (PDF, JPG)',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextArea(
          label: 'Notes / Comments',
          hint: 'Add personal notes...',
          value: _prescriptionNotes.isEmpty ? null : _prescriptionNotes,
          onChanged: (value) {
            setState(() {
              _prescriptionNotes = value;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildSectionTitle('Next Appointment'),
        const SizedBox(height: 12),
        DatePicker(
          label: 'Date',
          selectedDate: _nextAppointmentDate,
          onDateSelected: (date) {
            setState(() {
              _nextAppointmentDate = date;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.notifications, size: 20, color: Colors.grey[700]),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Remind me',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Get a notification before visit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            custom_switch.Switch(
              value: _remindMeEnabled,
              onChanged: (value) {
                setState(() {
                  _remindMeEnabled = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabReportForm() {
    return const Center(
      child: Text('Lab Report form coming soon'),
    );
  }

  Widget _buildReminderForm() {
    return const Center(
      child: Text('Reminder form coming soon'),
    );
  }

  Widget _buildMedicineStockForm() {
    return const Center(
      child: Text('Medicine Stock form coming soon'),
    );
  }

  Widget _buildAppointmentForm() {
    return const Center(
      child: Text('Appointment form coming soon'),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Button(
          label: 'Save Record',
          type: ButtonType.primary,
          size: ButtonSize.large,
          onPressed: _handleSaveRecord,
          color: Colors.green,
        ),
      ),
    );
  }
}

enum RecordType {
  medication,
  prescription,
  labReport,
  reminder,
  medicineStock,
  appointment,
}
