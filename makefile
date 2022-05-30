watch=fr735xt
sdkroot=/export/home/u8006988/projects/garmin/sdk/

Rings.prg : source/*.mc
	monkeyc  -y ../developer_key.der -o ./Rings.prg -f ./monkey.jungle 

run: Rings.prg
	connectiq &
	monkeydo ./Rings.prg ${watch}
	
package: 
	monkeyc -e -a ${sdkroot}/bin/api.db -i ${sdkroot}/bin/api.debug.xml -o ./Rings.iq -y ../developer_key.der -w -u ${sdkroot}/bin/devices.xml -p ${sdkroot}/bin/projectInfo.xml -f ./monkey.jungle
