import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'call_screen.dart';
import '../services/signalling.service.dart';

class JoinScreen extends StatefulWidget {
  final String selfCallerId;

  const JoinScreen({super.key, required this.selfCallerId});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  dynamic incomingSDPOffer;
  final remoteCallerIdTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // listen for incoming video call
    SignallingService.instance.socket!.on("newCall", (data) {
      if (mounted) {
        // set SDP Offer of incoming call
        setState(() => incomingSDPOffer = data);
      }
    });
  }

  // join Call
  _joinCall({
    required String callerId,
    required String calleeId,
    dynamic offer,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CallScreen(
          callerId: callerId,
          calleeId: calleeId,
          offer: offer,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xff1A1B23)),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Your Caller ID',
                          style: GoogleFonts.manrope(fontSize: 24),
                        ),
                        Text(widget.selfCallerId,
                            style: GoogleFonts.manrope(fontSize: 40))
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 32),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xff1A1B23)),
                    height: 320,
                    child: Column(
                      children: [
                        Text('Enter call ID of another user',
                            style: GoogleFonts.manrope(fontSize: 28)),
                        const SizedBox(
                          height: 16,
                        ),
                        TextField(
                          controller: remoteCallerIdTextEditingController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(fontSize: 20),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xff202427),
                            hintText: "Enter Caller ID",
                            hintStyle: GoogleFonts.manrope(fontSize: 20),
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (remoteCallerIdTextEditingController
                                    .text.isNotEmpty &&
                                remoteCallerIdTextEditingController
                                        .text.length ==
                                    6 &&
                                int.tryParse(remoteCallerIdTextEditingController
                                        .text) !=
                                    null) {
                              _joinCall(
                                callerId: widget.selfCallerId,
                                calleeId:
                                    remoteCallerIdTextEditingController.text,
                              );
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xff5568FE),
                            ),
                            child: Text(
                              "Call Now",
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (incomingSDPOffer != null)
              Positioned(
                child: Container(
                  color: Colors.white30,
                  child: ListTile(
                    title: Text(
                      "Incoming Call from ${incomingSDPOffer["callerId"]}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.manrope(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.call_end),
                            color: Colors.redAccent,
                            iconSize: 20,
                            onPressed: () {
                              setState(() => incomingSDPOffer = null);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          child: IconButton(
                            iconSize: 20,
                            icon: const Icon(Icons.call),
                            color: Colors.greenAccent,
                            onPressed: () {
                              _joinCall(
                                callerId: incomingSDPOffer["callerId"]!,
                                calleeId: widget.selfCallerId,
                                offer: incomingSDPOffer["sdpOffer"],
                              );
                              setState(() {
                                incomingSDPOffer = null;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
