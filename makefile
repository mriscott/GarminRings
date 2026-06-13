watch=fenix6


sdkroot="/Users/yane/Library/Application Support/Garmin/ConnectIQ/Sdks/connectiq-sdk-mac-9.1.0-2026-03-09-6a872a80b"

Rings.prg : source/*.mc
	monkeyc  -y developer_key.der -o ./Rings.prg -f ./monkey.jungle 

run: Rings.prg
	${sdkroot}/bin/monkeydo ./Rings.prg ${watch}

package: Rings.prg

	monkeyc -e -a ${sdkroot}/bin/api.db -i ${sdkroot}/bin/api.debug.xml -o ./Rings.iq -y developer_key.der -w -u ${sdkroot}/bin/devices.xml -p ${sdkroot}/bin/projectInfo.xml -f ./monkey.jungle


clean:
	rm Rings.prg Rings.iq
