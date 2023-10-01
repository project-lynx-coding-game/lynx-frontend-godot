extends LynxEntity
class_name LynxAction

@onready var _audio_node = get_node("/root/Scene/GlobalAudioEffect")
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
	self.execute_action_timer.wait_time = Globals.DEFAULT_ACTION_SPEED

func play_global_action(effect):
	self._audio_node.stream = effect
	self._audio_node.play()
	
