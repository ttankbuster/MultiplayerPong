extends Node

# Create the two peers
var p1 = WebRTCPeerConnection.new()
var p2 = WebRTCPeerConnection.new()
# And a negotiated channel for each peer
var ch1 = p1.create_data_channel("chat", {"id": 1, "negotiated": true})
var ch2 = p2.create_data_channel("chat", {"id": 1, "negotiated": true})

var ch1_opened = false
var ch2_opened = false

func _ready():
	# Connect P1 session created to itself to set local description.
	p1.session_description_created.connect(p1.set_local_description)
	# Connect P1 session and ICE created to p2 set remote description and candidates.
	p1.session_description_created.connect(p2.set_remote_description)
	p1.ice_candidate_created.connect(p2.add_ice_candidate)

	# Same for P2
	p2.session_description_created.connect(p2.set_local_description)
	p2.session_description_created.connect(p1.set_remote_description)
	p2.ice_candidate_created.connect(p1.add_ice_candidate)

	# Let P1 create the offer
	p1.create_offer()

func _process(_delta):
	# Poll connections
	p1.poll()
	p2.poll()

	# Check if ch1 is open
	if not ch1_opened and ch1.get_ready_state() == ch1.STATE_OPEN:
		ch1_opened = true
		ch1.put_packet("Hi from P1".to_utf8_buffer())
		print("Data channel 1 opened and message sent!")

	# Check if ch2 is open
	if not ch2_opened and ch2.get_ready_state() == ch2.STATE_OPEN:
		ch2_opened = true
		ch2.put_packet("Hi from P2".to_utf8_buffer())
		print("Data channel 2 opened and message sent!")

	# Check for messages
	if ch1.get_ready_state() == ch1.STATE_OPEN and ch1.get_available_packet_count() > 0:
		print("P1 received: ", ch1.get_packet().get_string_from_utf8())
	if ch2.get_ready_state() == ch2.STATE_OPEN and ch2.get_available_packet_count() > 0:
		print("P2 received: ", ch2.get_packet().get_string_from_utf8())
