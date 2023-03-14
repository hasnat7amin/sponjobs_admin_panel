import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: [
            dashboardCard(() { }, "All Users", "Total Users: 123", height),
            dashboardCard(() { }, "Active Users", "Active Users: 123", height),
            dashboardCard(() { }, "Blocked Users", "Blocked Users: 123", height),

          ],
        ),
      ),
    );
  }
}

Widget dashboardCard(VoidCallback func, String title, String desc,double height){
  return GestureDetector(
    onTap: func,
    child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: height*0.012,),
                Text(title,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(desc),
                    SizedBox(height: height*0.012,),
                  ],
                ),

              ],
            ),

          ],
        )
    ),
  );
}