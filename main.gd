extends Control

## get the scene for the spiral window
const SPIRAL_WINDOW = preload("uid://cmcc2s4qam082")

## the ui node that holds the number representing the minimum amount of time (in minutes)
## before the next attack
@onready var min: SpinBox = %min
## we allow the user to set the time in minutes, for ease of use.
## but we need to have these values in milliseconds for the time comp
var min_msec : int:
	get:
		min_msec = min.value*60*1000
		return min_msec
## same but for the maximum time (in minutes)
@onready var max: SpinBox = %max
## same at min_msec but for max
var max_msec : int:
	get:
		max_msec = max.value*60*1000
		return max_msec
@onready var button: Button = $VBoxContainer/Button

## the text that shows when the button is off
var btn_text_start : StringName = "press to start"
## the text that shows when the button is on
var btn_text_stop : StringName = "press to stop"

## track the time after which we will trigger the next attack
## we use -1 as the value to indicate we aren't waiting
var next_time_to_trigger : int = -1

## connect to the signal of the button. the button is a toggle.
## [br]when toggled on, we are waiting for the next attack
## [br]when toggled off, we are no longer waiting for an attack
func _on_button_toggled(toggled_on: bool) -> void:
	# update the button text accordingly
	button.text = btn_text_stop if toggled_on else btn_text_start
	if toggled_on:
		# capture the current time in milliseconds so we can create a delta time
		# to wait for to trigger the next attack
		var tmp_current_time : float = Time.get_ticks_msec()
		# generate new time to trigger
		next_time_to_trigger = randi_range(tmp_current_time+min_msec, tmp_current_time+max_msec)

## every loop, we check to see if the time has come to attack
func _process(delta: float) -> void:
	# check if it is time, and make sure we aren't set to disable
	if Time.get_ticks_msec() > next_time_to_trigger and button.button_pressed:
		# if it is time to attack, then we attack!!
		# start by creating a new instance of the spiral window
		var tmp_window : SpiralWindow = SPIRAL_WINDOW.instantiate()
		# release the button to reset TODO: add an option to loop 
		button.button_pressed = false
		# add the window to the tree
		add_child(tmp_window)
