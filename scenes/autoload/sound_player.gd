extends Node

@onready var audio_streams = $AudioStreams


func play_sound(stream: AudioStreamWAV):
	var audio_stream_players = audio_streams.get_children()
	
	for asp in audio_stream_players:
		var audio_stream_player = asp as AudioStreamPlayer
		
		if not audio_stream_player.playing:
			audio_stream_player.stream = stream
			audio_stream_player.play()
			break
