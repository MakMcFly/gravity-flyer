extends Node2D

const TYPE = "SWORD"

var maxAmount = 1 # How many of this item can be active at once
var side = "right"
var impulse = Vector2(200, 200)
var startingPosition = Vector2(100, 0)

func _ready():
	$Animation.connect("animation_finished", self, "destroy")
	$Animation.play(str("swing") + side)

func _process(delta):
	for area in $Area.get_overlapping_areas():
		var body = area.get_parent()
		if body.get("TYPE"):
			if body.get("TYPE") == "ENEMY":
				body.apply_impulse(Vector2(0, 0), impulse)

func destroy(animation):
#	if get_parent().has_method("state_swing"):
#		get_parent().state = "default"
	queue_free() # Delete itself