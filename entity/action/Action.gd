extends LynxEntity
class_name LynxAction

# method intended not to be overriden (no leading _)
# it is to be called to run an action
# action is destroyed from queue after running
func apply():
	await self._execute()
	self.queue_free()

# overide method, executes action
func _execute():
	pass
