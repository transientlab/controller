videoFile = "addscenes1.mp4"
VideoMode = "1920x1080x50p"
ScaleMode = 1
ClientIP = "192.168.0.11"

audioVolumeMute = 0
audioVolumeMin = 20
audioVolumeStd = 60
audioVolumeMax = 80

mode=CreateObject("roVideoMode")
mode.SetMode(VideoMode)

nc = CreateObject("roNetworkConfiguration", 0)

nc.SetIP4Address(ClientIP)
nc.SetIP4Netmask("255.255.255.0")
nc.SetIP4Broadcast("192.168.0.255")
nc.SetIP4Gateway("192.168.0.1")
nc.Apply()

receiver = CreateObject("roDatagramReceiver", 11167)

v = CreateObject("roVideoPlayer")
v.SetViewMode(ScaleMode)
v.SetVolume(audioVolumeStd)
v.SetLoopMode("AlwaysLoop")
sleep(200)

v.PreloadFile(videoFile)

p = CreateObject("roMessagePort")

receiver.SetPort(p)

listen:
	msg = wait(2000,p)

	if type(msg) = "roDatagramEvent" then 

        command = left(msg, 3)

		if command = "pre" then
				v.PreloadFile(videoFile)
		elseif command = "ply" then
				v.Play()
		elseif command = "pau" then
				v.Pause()
		elseif command = "res" then
				v.Resume()
		elseif command = "rst" then
				v.Stop()
		elseif command = "vl0" then
				v.SetVolume(audioVolumeMute)
		elseif command = "vl1" then
				v.SetVolume(audioVolumeMin)
		elseif command = "vl2" then
				v.SetVolume(audioVolumeStd)
		elseif command = "vl3" then
				v.SetVolume(audioVolumeMax)
		else
			print msg
		endif

	endif

	goto listen