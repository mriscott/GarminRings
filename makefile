watch=fenix6

sdkroot=/home/yane/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-8.4.1-2026-02-03-e9f77eeaa/

Rings.prg : source/*.mc
	${sdkroot}/bin/monkeyc  -y developer_key.der -o ./Rings.prg -f ./monkey.jungle 

sim:
	/home/yane/.Garmin/ConnectIQ/AppImages/Connect_IQ_Simulator-8.4.1+159-x86_64.AppImage &

run: Rings.prg
	${sdkroot}/bin/monkeydo ./Rings.prg ${watch}
	
package: Rings.prg
	${sdkroot}/bin/monkeyc -e -a ${sdkroot}/bin/api.db -i ${sdkroot}/bin/api.debug.xml -o ./Rings.iq -y developer_key.der -w -u ${sdkroot}/bin/devices.xml -p ${sdkroot}/bin/projectInfo.xml -f ./monkey.jungle

clean:
	rm Rings.prg Rings.iq
