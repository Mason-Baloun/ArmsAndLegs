from godot import exposed, export
from godot import *
from pydualsense import pydualsense, TriggerModes


@exposed
class PlayerV6_triggers(KinematicBody2D):

	def cross_pressed(state):
   	 print(state)

	ds = pydualsense() # open controller
	ds.init() # initialize controller
	# member variables here, example:
	N
	ds.triggerL.setMode(TriggerModes.Rigid)
	ds.triggerL.setResistance(1,255)
	def 
	def _ready(self):
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		pass
