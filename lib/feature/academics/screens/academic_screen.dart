import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socialapp/feature/academics/screens/lms_preview.dart';
import 'package:socialapp/feature/auth/controller/auth_controller.dart';
import 'package:socialapp/feature/settings/screens/settings_screen.dart';
import 'package:socialapp/theme/theme.dart';

class AcademicsPage extends ConsumerWidget {
  const AcademicsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final theme = ref.watch(themeNotifierProvider);

    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Academics',
            style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          imageUrl: user.profilePic,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 24, // Increased font size for name
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Career : UGRD',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for values
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Email : s@gmail.com',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for values
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Phone : 0XXXXXXXX',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for values
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 70, // Adjust height to fit the content
                    child: VerticalDivider(
                      color: isLightTheme ? Colors.black54 : Colors.grey[300],
                      width: 30, // Width of the divider
                      thickness: 2, // Thickness of the divider
                      indent: 0, // Space above the divider
                      endIndent: 0, // Space below the divider
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Batch : 2025',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for labels
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ERP : 26289',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for labels
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Program : BSCS',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, // Increased font size for labels
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: isLightTheme ? Colors.black54 : Colors.grey[300],
                thickness: 2, // Thickness of the divider
                indent: 0, // Space above the divider
                endIndent: 0, // Space below the divider),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(TabScreen.route());
                },
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color:
                        Colors.red.shade300, // Maroon color for the container
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Learning Management System',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontSize: 20, // Font size for "LMS"
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Text color to contrast with maroon
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/logo.png', // Replace with your image path
                            width: 40, // Width of the image
                            height: 40, // Height of the image
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Menu(
                title: 'Check Attendence',
                description: 'Minimum of 5 absences allowed',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.note_alt_outlined,
              ),
              const SizedBox(height: 5),
              Menu(
                title: 'Timetable',
                description:
                    'Check either you semster timetable or exam timetable',
                textStyle: theme.textTheme.headlineSmall,
                endIcon: Icons.keyboard_arrow_right,
                onpress: () {},
                icon: Icons.table_chart_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
