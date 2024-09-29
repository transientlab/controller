' Brightsign Multi-Screen Sync Script - MASTER
' --------------------------------------------
' Modified by Zach Poff (zachpoff.com) from scripts provided by Brightsign
 
' STEP 1
' ------
' Prepare your SD card by choosing the right format: 
' Windows users: For videos under 4gig, FAT32 is OK. Otherwise use NTFS. 
' Mac users: Use "Mac OS Extended". (Update Brightsign firmware if player won't recognize card.)
' Linux users: Use EXT3
' http://support.brightsign.biz/entries/20403507-What-file-system-can-I-use-with-the-BrightSign-
' Copy this script file and your video onto the SD card.

' STEP 2
' ------
' Set the following variables.

videoFile = "OBRAZ_3_V2.mp4"
'    (the filename of your video, in quotes)

VideoMode$ = "1920x1080x60p"
'    (the output resolution and refresh rate from list below, in quotes)

audioVolume1 = 0
audioVolume2 = 30
audioVolume3 = 50
audioVolume4 = 70
'    (the volume of the audio output, in percent... 
'     These players have LOUD outputs so try 10-20 for sane headphone levels!)

' *** Scroll down to the "Setting Manual IP address" section if you
'     want to choose a different IP range.

' STEP 3
' ------
' Insert SD cards into players. Connect all players via ethernet and turn them on.
' Within 30 sec, all players should be playing in sync.

' VIDEO MODES on HD120, HD220, and HD1020 players
' -----------------------------------------------

'    Component requires an adapter: http://support.brightsign.biz/entries/22929977-Can-I-use-component-and-composite-video-with-BrightSign-players-
'    via HDMI / Component:
'    ---------------------
'    ntsc-component
'    pal-component 
'    ntsc-m 
'    ntsc-m-jpn 
'    pal-i 
'    pal-bg 
'    pal-n 
'    pal-nc 
'    pal-m 
'    720x576x50p
'    720x480x59.94p
'    720x480x60p
'    1280x720x50p
'    1280x720x59.94p
'    1280x720x60p
'    1920x1080x50i
'    1920x1080x59.94i
'    1920x1080x60i
'    1920x1080x24p   (not backwards compatible)
'    1920x1080x29.97p
'    1920x1080x30p   (not backwards compatible)
'    1920x1080x50p
'    1920x1080x59.94p
'    1920x1080x60p

'    via HDMI / VGA:
'    ---------------
'    640x480x60p 
'    800x600x60p 
'    800x600x75p 
'    1024x768x60p 
'    1024x768x75p 
'    1280x768x60p 
'    1280x800x60p 
'    1360x768x60p 

' CHANGELOG:
' ---------------
' 2013-11-15 Changes from scripts provided by Brightsign:
'    - Removed zone support 
'    - Extended preloading time to make sure big files would preload
'    - added instructions and comments

REM Setting Manual IP address
nc = CreateObject("roNetworkConfiguration", 0)
nc.SetIP4Address("192.168.0.10")
nc.SetIP4Netmask("255.255.255.0")
nc.SetIP4Broadcast("192.168.0.255")
nc.SetIP4Gateway("192.168.0.1")
nc.Apply()


REM
REM IP address 255.255.255.255 sends to all units
sender = CreateObject("roDatagramSender")
sender.SetDestination("255.255.255.255", 11167)

' receiver = CreateObject("roDatagramReceiver", 11166)
' pr = CreateObject("roMessagePort")
' receiver.SetPort(pr)

v = CreateObject("roVideoPlayer")

p = CreateObject("roMessagePort")
v.SetPort(p)
v.SetVolume(audioVolume)

mode=CreateObject("roVideoMode")
mode.SetMode(VideoMode$)


sleep(10000)

start:
	print "start"
	sender.Send("pre")
	v.PreloadFile(videoFile)
	' now we pause to give brightsigns time to preload the vid
	sleep(5000)
	sender.Send("ply")
	v.Play()


listen:
	msg = wait(2000,p)
	
	if type(msg) = "roVideoEvent" and msg.GetInt() = 8 then
	    sleep(1000) ' to jest sekunda czekania po zakończonym materiale
		goto start
	elseif type(msg) = "roDatagramEvent" then
		command = left(msg, 3)
		if command = "rst" then
			v.Stop()
			goto start
		elseif command = "vl1" then
			v.SetVolume(audioVolume1)
		elseif command = "vl2" then
			v.SetVolume(audioVolume2)
		elseif command = "vl3" then
			v.SetVolume(audioVolume3)
		elseif command = "vl4" then
			v.SetVolume(audioVolume4)
		elseif command = "pau" then
			v.Pause()
		elseif command = "res" then
			v.Resume()
		else
			print msg
		endif
	endif

	goto listen
