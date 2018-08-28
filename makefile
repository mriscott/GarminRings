sdkroot=c:\users\u8006988\garminSDK
projectroot=c:\users\u8006988\projects\GarminRings


build :
	$(sdkroot)\bin\monkeyc  -y $(sdkroot)\keys\developer_key.der -o $(projectroot)\Rings.prg -f $(projectroot)\monkey.jungle 

run: build
	$(sdkroot)\bin\connectiq
	$(sdkroot)\bin\monkeydo $(projectroot)\Rings.prg fr735xt

rerun:	
	$(sdkroot)\bin\monkeydo $(projectroot)\Rings.prg fr735xt
