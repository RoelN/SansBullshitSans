#!/bin/sh -

if [ ! "$#" -eq 1 ] ; then
  /bin/echo "Usage: $0 fontfilename"
  exit 1
fi

fontfile=$1
outfile=$fontfile\.mobileconfig
outeruuid=`uuidgen`
inneruuid=`uuidgen`
/bin/echo -n '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>PayloadDisplayName</key><string>' > $outfile
/bin/echo -n $fontfile >> $outfile
/bin/echo -n '</string>
<key>PayloadIdentifier</key>
<string>' >> $outfile
/bin/echo -n `hostname`.$outeruuid >> $outfile
/bin/echo -n '</string>
<key>PayloadType</key><string>Configuration</string>
<key>PayloadUUID</key><string>' >> $outfile
/bin/echo -n $outeruuid >> $outfile
/bin/echo -n '</string>' >> $outfile
/bin/echo -n '<key>PayloadVersion</key><integer>1</integer>
<key>PayloadContent</key>
<array>
<dict>
<key>PayloadType</key><string>com.apple.font</string>
<key>Font</key>
<data>' >> $outfile
base64 -b 72 -i $fontfile >> $outfile
/bin/echo -n '</data>
<key>Name</key>
<string>' >> $outfile
/bin/echo -n $fontfile >> $outfile
/bin/echo -n '</string>
<key>PayloadIdentifier</key>
<string>' >> $outfile
/bin/echo -n `hostname`.$outeruuid.com.apple.font.$inneruuid >> $outfile
/bin/echo -n '</string>
<key>PayloadVersion</key><integer>1</integer>
<key>PayloadUUID</key><string>' >> $outfile
/bin/echo -n $inneruuid >> $outfile
/bin/echo '</string>
</dict>
</array>
</dict>
</plist>' >> $outfile
