videoFile = "OBRAZ_3_V2.mp4"
VideoMode = "1920x1080x60p"
ScaleMode = 1

audioVolumeMute = 0
audioVolumeMin = 20
audioVolumeStd = 50
audioVolumeMax = 80

nc = CreateObject("roNetworkConfiguration", 0)
nc.SetIP4Address("192.168.0.10")
nc.SetIP4Netmask("255.255.255.0")
nc.SetIP4Broadcast("192.168.0.255")
nc.SetIP4Gateway("192.168.0.1")
nc.Apply()

sender = CreateObject("roDatagramSender")
sender.SetDestination("255.255.255.255", 11167)

v = CreateObject("roVideoPlayer")

v.SetViewMode(ScaleMode)
v.SetVolume(audioVolumeStd)
v.SetLoopMode("AlwaysLoop")

receiver = CreateObject("roDatagramReceiver", 11166)
p = CreateObject("roMessagePort")
receiver.SetPort(p)

mode=CreateObject("roVideoMode")
mode.SetMode(VideoMode)

sleep(500)

start:
	print "start"
	sender.Send("pre")
	v.PreloadFile(videoFile)
	sleep(500)
	sender.Send("ply")

	v.Play()

listen:
	msg = wait(2000,p)
	if type(msg) = "roDatagramEvent" then 

        command = left(msg, 3)
		if command = "pau" then
				sender.Send("pau")
				v.Pause()
		elseif command = "res" then
				sender.Send("res")
				v.Resume()
		elseif command = "rst" then
				v.Stop()
				goto start
		elseif command = "vl0" then
				sender.Send("vl0")
				v.SetVolume(audioVolumeMute)
		elseif command = "vl1" then
				sender.Send("vl1")
				v.SetVolume(audioVolumeMin)
		elseif command = "vl2" then
				sender.Send("vl2")
				v.SetVolume(audioVolumeStd)
		elseif command = "vl3" then
				sender.Send("vl3")
				v.SetVolume(audioVolumeMax)
		else
			print msg
		endif

	endif

	goto listen