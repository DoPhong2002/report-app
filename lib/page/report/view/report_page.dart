import 'package:exercise_demo/bloc/issue_bloc.dart';
import 'package:exercise_demo/comon/data_local/hive_manager.dart';
import 'package:exercise_demo/comon/navigator.dart';
import 'package:exercise_demo/const/const.dart';
import 'package:exercise_demo/models/issue.dart';
import 'package:exercise_demo/models/service/api_service.dart';
import 'package:exercise_demo/page/add_report/view/add_report_page.dart';
import 'package:exercise_demo/page/change_password/view/change_password_page.dart';
import 'package:exercise_demo/page/login/view/login_page.dart';
import 'package:exercise_demo/page/profile/view/profile_page.dart';
import 'package:exercise_demo/page/report/page/item_report.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final issueBloc = IssueBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report'),
        ),
        drawer: buildDrawer(),
        body: buildList());
  }

  Widget buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              navigatorPush(context, const Profile());
            },
            child: buildTitle(),
          ),
          buildListIcons(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Stack(
      children: [
        Image.network(
          'https://taoanhdep.com/wp-content/uploads/2022/08/hinh-nen-may-cuc-dep-350x265.jpeg',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 24,
          bottom: 24,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: buildAvt()),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${apiService.user?.name}',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  ),
                  Text(
                    '${apiService.user?.phoneNumber}',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildAvt() {
    if (apiService.user?.avatar != null) {
      return Image.network(
        apiService.user?.avatar ?? '',
        fit: BoxFit.cover,
      );
    }
    return Image.network(
        'https://scr.vn/wp-content/uploads/2020/07/Avatar-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-m%C3%A0u-s%E1%BA%AFc.jpg');
  }

  Widget buildListIcons() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddReportPage()),
            );
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.menu, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Add Report',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () {},
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.report, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Báo cáo',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () {
            navigatorPush(context, ChangePasswordPage());
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.pan_tool_alt_sharp, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Đổi mật khẩu',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () {},
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.rule_folder, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Điều khoản',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () {},
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.phone, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Liên hệ',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 2,
          color: Colors.grey[300],
        ),
        InkWell(
          onTap: () {
            logOut();
          },
          child: SizedBox(
            height: 50,
            child: Row(
              children: const [
                Icon(Icons.logout, size: 32),
                SizedBox(
                  width: 8,
                ),
                Text(
                  'Đăng xuất',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void logOut() {
    hive.removeValue();
    navigatorPushAndRemoveUntil(context, const LoginPage());
  }

  Widget buildList() {
    return StreamBuilder<List<Issue>>(
      stream: issueBloc.streamIssue,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.hasData) {
          final issues = snapshot.data ?? [];
          return ListView.separated(
            separatorBuilder: (_, __) {
              return const Divider();
            },
            itemCount: issues.length,
            itemBuilder: (context, index) {
              if (index == issues.length - 1) {
                issueBloc.getIssues();
              }
              final issue = issues[index];
              return ItemReport(issue: issue);
            },
          );
        }
        return Container(
          color: Colors.yellow,
        );
      },
    );
  }
}
