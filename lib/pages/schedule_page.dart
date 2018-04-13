import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_conference/model/schedules.dart';
import 'package:app_conference/ui/common/card.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => new _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> with SingleTickerProviderStateMixin {

  TabController controller;
  List<Schedule> schedules = [];

  @override
  void initState() {
    loadSchedule().then((List<Schedule> data) {
      setState(() {
        schedules = data;
      });
    });
    controller = new TabController(vsync: this, length: schedules.length);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          appBar: new AppBar(
            backgroundColor: new Color.fromRGBO(255, 22, 65, 10.0),
            title: new Text('Shchedule'.toUpperCase(), style: new TextStyle(
              letterSpacing: 8.0,
            ),),
            centerTitle: true,
            bottom: new PreferredSize(
              preferredSize: new Size.fromHeight(80.0),
              child: new Container(
                padding: new EdgeInsets.only(bottom: 20.0),
                child: new TabBar(
                  labelStyle: new TextStyle(
                    fontSize: 14.0
                  ),
                  indicatorWeight: 8.0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  unselectedLabelColor: Colors.white,
                  labelColor: new Color.fromRGBO(255, 22, 65, 10.0),
                  indicator: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                        new BoxShadow (
                          color: const Color(0xcc000000),
                          offset: new Offset(0.0, 0.1),
                          blurRadius: 0.1,
                        ),
                      ],
                    ),
                  controller: controller,
                  isScrollable: true,
                  tabs: schedules.map((Schedule schedules) {
                  return new Tab(
                      child: new Align(
                        alignment: Alignment.bottomCenter,
                        child: new Container(
                          padding: new EdgeInsets.all(5.0),
                          child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                              new Text(schedules.dia.toUpperCase()),
                              new Text(schedules.mes.toUpperCase())
                            ],
                          )
                        ),
                      )
                    );
                 }).toList(),
               ),
              ),
            ),
          ),
          body: new TabBarView(
            controller: controller,
            children: schedules.map((Schedule schedule) {
              return new ScheduleCard(schedules: schedule.sessoes,);
            }).toList(),
          ),
    );
  }
}



class ScheduleCard extends StatelessWidget {
  final List<Object> schedules;

  ScheduleCard({ this.schedules });

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return new Container(
      child: new Container(
//        color: new Color(0xFF736AB7),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              sliver: new SliverList(
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new CardSummary(schedules[index]),
                  childCount: schedules.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}