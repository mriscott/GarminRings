watch=fenix5s

sdkroot=/home/yane/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-4.1.2-2022-04-07-15e8df3ed/
Rings.prg : source/*.mc
	monkeyc  -y ../developer_key.der -o ./Rings.prg -f ./monkey.jungle 

run: Rings.prg
	connectiq &
	monkeydo ./Rings.prg ${watch}
	
package: Rings.prg
	monkeyc -e -a ${sdkroot}/bin/api.db -i ${sdkroot}/bin/api.debug.xml -o ./Rings.iq -y ../developer_key.der -w -u ${sdkroot}/bin/devices.xml -p ${sdkroot}/bin/projectInfo.xml -f ./monkey.jungle

clean:
	rm Rings.prg Rings.iq
