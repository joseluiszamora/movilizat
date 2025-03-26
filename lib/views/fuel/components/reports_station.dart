import 'package:flutter/material.dart';
import 'package:movilizat/core/layouts/layout_wrapper_modal_bottom.dart';

class ReportsStation extends StatelessWidget {
  const ReportsStation({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutWrapperModalBottom(
      title: "Ultimos Reportes",
      child: Expanded(
        child: ListView.builder(
          itemCount: reportsData.length,
          itemBuilder: (context, index) => ChatCard(
            report: reportsData[index],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.press, required this.report});

  final Report report;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0 * 0.75),
        child: Row(
          children: [
            CircleAvatarWithActiveIndicator(
              image: report.image,
              isActive: report.isActive,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 8),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        report.lastMessage,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.64,
              child: Text(report.time),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(image!),
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: const Color(0xFF00BF6D),
                shape: BoxShape.circle,
                border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor, width: 3),
              ),
            ),
          )
      ],
    );
  }
}

class Report {
  final String name, lastMessage, image, time;
  final bool isActive;
  final int timeFila, numVehiculos;

  Report({
    this.name = '',
    this.lastMessage = '',
    this.image = '',
    this.time = '',
    this.isActive = false,
    this.timeFila = 0,
    this.numVehiculos = 0,
  });
}

List reportsData = [
  Report(
    name: "Jenny Wilson",
    lastMessage: "2 horas de fila y 100 vehiculos, estación activa",
    image: "https://i.postimg.cc/g25VYN7X/user-1.png",
    time: "3m ago",
    isActive: false,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Esther Howard",
    lastMessage: "2 horas de fila y 100 vehiculos",
    image: "https://i.postimg.cc/cCsYDjvj/user-2.png",
    time: "8m ago",
    isActive: true,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://i.postimg.cc/sXC5W1s3/user-3.png",
    time: "5d ago",
    isActive: false,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "https://i.postimg.cc/4dvVQZxV/user-4.png",
    time: "5d ago",
    isActive: true,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Albert Flores",
    lastMessage: "Thanksddd",
    image: "https://i.postimg.cc/FzDSwZcK/user-5.png",
    time: "6d ago",
    isActive: false,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "https://i.postimg.cc/g25VYN7X/user-1.png",
    time: "3m ago",
    isActive: false,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "https://i.postimg.cc/cCsYDjvj/user-2.png",
    time: "8m ago",
    isActive: true,
    timeFila: 5,
    numVehiculos: 10,
  ),
  Report(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "https://i.postimg.cc/sXC5W1s3/user-3.png",
    time: "5d ago",
    isActive: false,
    timeFila: 5,
    numVehiculos: 10,
  ),
];
