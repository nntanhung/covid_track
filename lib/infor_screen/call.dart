import 'package:url_launcher/url_launcher.dart';

final String phone = 'tel:19009095';
const url = 'https://ncov.moh.gov.vn/';
callPhone() async {
  if (await canLaunch(phone)) {
    await launch(phone);
  } else {
    throw 'Could not Call Phone';
  }
}

launchURL() async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
