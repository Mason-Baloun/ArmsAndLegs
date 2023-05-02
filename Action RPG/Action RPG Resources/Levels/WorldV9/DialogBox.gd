extends ColorRect

export var dialogPath = "res://Action RPG/Action RPG Resources/Levels/WorldV9/Dialog0.json"
export(float) var textSpeed = 0.001

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Unable to find dialog in file")
	nextPhrase()
	
func _process(_delta):
	if Input.is_action_just_pressed("space"):
		if finished:
			nextPhrase() # Shows next text line
		else:
			$Text.visable_characters = len($Text.text)
			
	
func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "Unable to find dialog file in specified path")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
	
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Name.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1 # Sets text visability to scroll letter by letter
		
		$Timer.start()
		yield($Timer, "timeout") # Uses timer to decide how fast to scroll text
		
	finished = true
	print("finished")
	phraseNum += 1
	return
		
