To test the master device functionalities through the C++ program. This page is a testplan document for the master device.
*relative links*
- [[vips/ahb5/test/testplan-master_DRVR]]

# ENV Architecture
This test will use C++ program, one reason is to test the functionalities of the master VIP, another reason is to build a simple verification ENV through C++ and VPI, which be a reference for later ==DCVP== project.
The basic solution of the env architecture is to call a c++ test by VPI from tb level, and a DPI is provided by the master VIP to start a sequence for the master device. Then use C++ to collect information on the interface and check the correctiveness.
*requirements*
- Testname given through the plusargs and pass through the VPI in tb base.
- The ==simf== flow may not support CPP+SV verification, will collect requirements for next flow generation.
- 