extends Node2D

const TYPE = "SWORD"

var maxAmount = 1 # How many of this item can be active at once
var side = "right"
var hasHit = false

func _ready():
	$Animation.connect("animation_finished", self, "destroy")
	$Animation.play(str("swing") + side)

func _process(delta):
	for area in $Area.get_overlapping_areas():
		var body = area.get_parent()
		var impulse = Vector2(300, 300)
		if body.get("TYPE"):
			if body.get("TYPE") == "ENEMY" and !hasHit:
				if $Animation.current_animation == "swingleft":
					impulse = Vector2(-300, 300)
				body.set_linear_velocity(Vector2(0, 0))
				body.set_angular_velocity(0)
				body.apply_impulse(Vector2(0, 0), impulse)
				hasHit = true

func destroy(animation):
	queue_free() # Delete itself