import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle _heading = TextStyle(
        fontSize: 22, color: Colors.black, fontWeight: FontWeight.w600);
    TextStyle _smallHeading = TextStyle(
        fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600);
    TextStyle _mediumHeading = TextStyle(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600);
    TextStyle _content = TextStyle(fontSize: 15, color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Privacy Policy'),
        centerTitle: true,
        // automaticallyImplyLeading: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Privacy Policy',
                          style: _heading,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "This Privacy Policy describes Our policies and procedures "
                          "on the collection, use and disclosure of Your information "
                          "when You use the Service and tells You about Your privacy "
                          "rights and how the law protects You"
                          "We use Your Personal data to provide and improve the Service. "
                          "By using the Service, You agree to the collection and use "
                          "of information in accordance with this Privacy Policy.",
                          textAlign: TextAlign.justify,
                          style: _content,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Interpretation and Definitions',
                          style: _heading,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        child: Text(
                          'Interpretation',
                          style: _mediumHeading,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "The words of which the initial letter is capitalized have meanings defined under "
                          "the following conditions. The following definitions shall have "
                          "the same meaning regardless of whether they appear in singular or in plural.",
                          textAlign: TextAlign.justify,
                          style: _content,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        child: Text(
                          'Definitions',
                          style: _mediumHeading,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              // String.fromCharCode(0x2022)
                              "For the purposes of this Privacy Policy:\n",
                            ),
                            Text(
                              String.fromCharCode(0x2022) +
                                  " " +
                                  "Account means a unique account created for You to access our Service or"
                                      "parts of our Service.\n",
                              textAlign: TextAlign.justify,
                              style: _content,
                            ),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Affiliate means an entity that controls, is controlled by or is"
                                        "under common control with a party, where 'control' means ownership "
                                        "of 50% or more of the shares, equity interest or other securities "
                                        "entitled to vote for election of directors or other managing authority.\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Application means the software program "
                                        "provided by the Company downloaded by You on any "
                                        "electronic device, named UGC NET Notes\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Company (referred to as either 'the Company', 'We', 'Us' or 'Our' "
                                        "in this Agreement) refers to UGC NET Notes.\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Country refers to: Telangana, India\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Device means any device that can access the Service such as a "
                                        "computer, a cellphone or a digital tablet.\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Personal Data is any information that relates to an identified "
                                        "or identifiable individual.\n",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Service refers to the Application.\n",
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Service Provider means any natural or legal person who processes "
                                        "the data on behalf of the Company. It refers to third-party "
                                        "companies or individuals employed by the Company to facilitate "
                                        "the Service, to provide the Service on behalf of the Company, "
                                        "to perform services related to the Service or to assist the "
                                        "Company in analyzing how the Service is used.\n",
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Third-party Social Media Service refers to any website or any "
                                        "social network website through which a User can log in or "
                                        "create an account to use the Service.\n",
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Usage Data refers to data collected automatically, either "
                                        "generated by the use of the Service or from the Service "
                                        "infrastructure itself (for example, the duration of a page visit).\n",
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "You means the individual accessing or using the Service, or"
                                        " the company, or other legal entity on behalf of which "
                                        "such individual is accessing or using the Service, as applicable.",
                                textAlign: TextAlign.justify,
                                style: _content),
                          ],
                        ),
                      ),

                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Collecting and Using Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Types of Data Collected',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Personal Data',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "While using Our Service, We may ask You to provide Us with certain "
                                "personally identifiable information that can be used to contact "
                                "or identify You. Personally identifiable information may include, but is not limited to:",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Email address",
                                textAlign: TextAlign.justify,
                                style: _content),
                            Text(
                                String.fromCharCode(0x2022) +
                                    " " +
                                    "Usage Data",
                                textAlign: TextAlign.justify,
                                style: _content),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Usage Data',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Usage Data is collected automatically when using the Service.\n\n"
                                "Usage Data may include information such as Your Device's Internet "
                                "Protocol address (e.g. IP address), browser type, browser version, "
                                "the pages of our Service that You visit, the time and date of Your "
                                "visit, the time spent on those pages, unique device identifiers and "
                                "other diagnostic data.\n\n"
                                "When You access the Service by or through a mobile device, We may collect "
                                "certain information automatically, including, but not limited to, the "
                                "type of mobile device You use, Your mobile device unique ID, the IP "
                                "address of Your mobile device, Your mobile operating system, the type "
                                "of mobile Internet browser You use, unique device identifiers and other "
                                "diagnostic data.\n\n"
                                "We may also collect information that Your browser sends whenever You visit "
                                "our Service or when You access the Service by or through a mobile device.\n\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            )
                          ],
                        ),
                      ),
                      /////////////////////////////
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Use of Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    // String.fromCharCode(0x2022)
                                    "The Company may use Personal Data for the following purposes:\n",
                                  ),
                                  Text(
                                    String.fromCharCode(0x2022) +
                                        " " +
                                        "To provide and maintain our Service, including to monitor "
                                            "the usage of our Service.\n",
                                    textAlign: TextAlign.justify,
                                    style: _content,
                                  ),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "To manage Your Account: to manage Your registration as a "
                                              "user of the Service. The Personal Data You provide can "
                                              "give You access to different functionalities of the "
                                              "Service that are available to You as a registered user.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "For the performance of a contract: the development, "
                                              "compliance and undertaking of the purchase contract "
                                              "for the products, items or services You have purchased "
                                              "or of any other contract with Us through the Service.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "To contact You: To contact You by email, telephone calls, "
                                              "SMS, or other equivalent forms of electronic communication, "
                                              "such as a mobile application's push notifications regarding "
                                              "updates or informative communications related to the functionalities, "
                                              "products or contracted services, including the security updates, "
                                              "when necessary or reasonable for their implementation.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "To provide You with news, special offers and general information "
                                              "about other goods, services and events which we offer that "
                                              "are similar to those that you have already purchased or "
                                              "enquired about unless You have opted not to receive such information.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "To manage Your requests: To attend and manage Your requests to Us.",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "For business transfers: We may use Your information to evaluate "
                                              "or conduct a merger, divestiture, restructuring, reorganization, "
                                              "dissolution, or other sale or transfer of some or all of Our "
                                              "assets, whether as a going concern or as part of bankruptcy, "
                                              "liquidation, or similar proceeding, in which Personal Data held "
                                              "by Us about our Service users is among the assets transferred.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "For other purposes: We may use Your information for other purposes, "
                                              "such as data analysis, identifying usage trends, determining the "
                                              "effectiveness of our promotional campaigns and to evaluate and "
                                              "improve our Service, products, services, marketing and your experience.\n",
                                      style: _content),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                        "We may share Your personal information in the following situations:",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 19)),
                                  ),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "With Service Providers: We may share Your personal information "
                                              "with Service Providers to monitor and analyze the use of our "
                                              "Service, to contact You.\n",
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "For business transfers: We may share or transfer Your personal "
                                              "information in connection with, or during negotiations of,"
                                              " any merger, sale of Company assets, financing, or acquisition"
                                              " of all or a portion of Our business to another company.\n",
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "With Affiliates: We may share Your information with Our affiliates, "
                                              "in which case we will require those affiliates to honor this Privacy "
                                              "Policy. Affiliates include Our parent company and any other subsidiaries, "
                                              "joint venture partners or other companies that We control or that are under "
                                              "common control with Us.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "With business partners: We may share Your information with Our"
                                              " business partners to offer You certain products, services "
                                              "or promotions.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "With other users: when You share personal information or otherwise "
                                              "interact in the public areas with other users, such information"
                                              " may be viewed by all users and may be publicly distributed outside."
                                              " If You interact with other users or register through a"
                                              " Third-Party Social Media Service, Your contacts on the "
                                              "Third-Party Social Media Service may see Your name, profile, "
                                              "pictures and description of Your activity. Similarly, other users "
                                              "will be able to view descriptions of Your activity, communicate"
                                              "with You and view Your profile.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "With Your consent: We may disclose Your personal information "
                                              "for any other purpose with Your consent.",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Use of Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "The Company will retain Your Personal Data only for as long as "
                                "is necessary for the purposes set out in this Privacy Policy. "
                                "We will retain and use Your Personal Data to the extent necessary "
                                "to comply with our legal obligations (for example, if we are required "
                                "to retain your data to comply with applicable laws), resolve disputes, "
                                "and enforce our legal agreements and policies.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "The Company will also retain Usage Data for internal analysis "
                                "purposes. Usage Data is generally retained for a shorter "
                                "period of time, except when this data is used to strengthen "
                                "the security or to improve the functionality of Our Service, "
                                "or We are legally obligated to retain this data for longer time periods.",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Transfer of Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Your information, including Personal Data, is processed "
                                "at the Company's operating offices and in any other "
                                "places where the parties involved in the processing "
                                "are located. It means that this information may be "
                                "transferred to — and maintained on — computers located "
                                "outside of Your state, province, country or other governmental "
                                "jurisdiction where the data protection laws may differ than "
                                "those from Your jurisdiction.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Your consent to this Privacy Policy followed by Your submission "
                                "of such information represents Your agreement to that transfer.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "The Company will take all steps reasonably necessary to ensure that "
                                "Your data is treated securely and in accordance with this Privacy "
                                "Policy and no transfer of Your Personal Data will take place to an "
                                "organization or a country unless there are adequate controls in"
                                " place including the security of Your data and other personal information.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Disclosure of Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Business Transactions',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "If the Company is involved in a merger, acquisition or asset "
                                "sale, Your Personal Data may be transferred. We will provide "
                                "notice before Your Personal Data is transferred and becomes "
                                "subject to a different Privacy Policy.",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Law enforcement',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Under certain circumstances, the Company may be required to disclose "
                                "Your Personal Data if required to do so by law or in response "
                                "to valid requests by public authorities (e.g. a court or a government agency).",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              child: Text(
                                'Other legal requirements',
                                style: _mediumHeading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "The Company may disclose Your Personal Data in the good faith "
                                "belief that such action is necessary to:",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      // String.fromCharCode(0x2022)
                                      "The Company may use Personal Data for the following purposes:\n",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    String.fromCharCode(0x2022) +
                                        " " +
                                        "Comply with a legal obligation",
                                    textAlign: TextAlign.justify,
                                    style: _content,
                                  ),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "Protect and defend the rights or property of the Company",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "Prevent or investigate possible wrongdoing in connection with the Service",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "Protect the personal safety of Users of the Service or the public",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                  Text(
                                      String.fromCharCode(0x2022) +
                                          " " +
                                          "Protect against legal liability",
                                      textAlign: TextAlign.justify,
                                      style: _content),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Security of Your Personal Data',
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "The security of Your Personal Data is important to Us, but "
                                "remember that no method of transmission over the Internet, "
                                "or method of electronic storage is 100% secure. While We strive "
                                "to use commercially acceptable means to protect Your Personal Data,"
                                " We cannot guarantee its absolute security.",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Children's Privacy",
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Our Service does not address anyone under the age of 13. "
                                "We do not knowingly collect personally identifiable "
                                "information from anyone under the age of 13. "
                                "If You are a parent or guardian and You are aware that "
                                "Your child has provided Us with Personal Data, please "
                                "contact Us. If We become aware that We have collected "
                                "Personal Data from anyone under the age of 13 without "
                                "verification of parental consent, We take steps to remove "
                                "that information from Our servers.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "If We need to rely on consent as a legal basis for processing "
                                "Your information and Your country requires consent from a "
                                "parent, We may require Your parent's consent before "
                                "We collect and use that information.",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Links to Other Websites",
                                style: _heading,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Our Service may contain links to other websites that are not "
                                "operated by Us. If You click on a third party link, "
                                "You will be directed to that third party's site. "
                                "We strongly advise You to review the Privacy Policy "
                                "of every site You visit.\n",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "We have no control over and assume no responsibility for the content, "
                                "privacy policies or practices of any third party sites or services.",
                                textAlign: TextAlign.justify,
                                style: _content,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Changes to this Privacy Policy",
                                      style: _heading,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "We may update Our Privacy Policy from time to time. "
                                      "We will notify You of any changes by posting the "
                                      "new Privacy Policy on this page.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "We will let You know via email and/or a prominent notice on "
                                      "Our Service, prior to the change becoming effective and"
                                      " update the 'Last updated' date at the top of this Privacy Policy.\n",
                                      textAlign: TextAlign.justify,
                                      style: _content,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "You are advised to review this Privacy Policy periodically "
                                      "for any changes. Changes to this Privacy Policy are "
                                      "effective when they are posted on this page.",
                                      textAlign: TextAlign.justify,
                                      style: _content,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Contact Us",
                                      style: _heading,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "If you have any questions about this Privacy Policy, You can contact us:\n",
                                      textAlign: TextAlign.justify,
                                      style: _content,
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                              String.fromCharCode(0x2022) +
                                                  " " +
                                                  "By email: tests@ugcnetapp.in",
                                              textAlign: TextAlign.justify,
                                              style: _content),
                                          Text(
                                              String.fromCharCode(0x2022) +
                                                  " " +
                                                  "By visiting this page on our website: www.ugcnetapp.in",
                                              textAlign: TextAlign.justify,
                                              style: _content),
                                          Text(
                                              String.fromCharCode(0x2022) +
                                                  " " +
                                                  "By phone number: 8712150150",
                                              textAlign: TextAlign.justify,
                                              style: _content),
                                        ],
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
