# CA Cloning Scripts
Scripts to clone CA certificates for use in HTTPS client attacks. Currently includes scripts to clone a root Comodo CA, and a Digicert CA, both of which are fairly widely trusted in IoT devices.

## Usage
* Run either script in place to automatically generate a key and certificate. In general, you only need to run one or the other, but both are included here in case you suspect a specific CA is needed.
* Import the generated P12 into your HTTPS proxy.
  * In Burp, this is done by importing the P12 file as a CA Certificate under Proxy -> Options. Don't forget to backup your current CA!
