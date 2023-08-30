extends LynxEntity
class_name LynxAction

@onready var _audio_node = get_node("/root/Scene/AudioEffect")

# method intended not to be overriden (no leading _)
# it is to be called to run an action
# action is destroyed from queue after running
func apply():
	await self._execute()
	self.queue_free()

# overide method, executes action
func _execute():
	pass
	
func _post_populate():
	self.execute_action_timer.wait_time = Config.DEFAULT_ACTION_SPEED
	
#Function used to play sound evenly on whole scene, like sound of error, or announcement
func play_audio_global_effect(effect):
	self._audio_node.stream = effect
	self._audio_node.play()
