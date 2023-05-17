extends Sprite

func _ready():
	pass # Replace with function body.



func _on_InstellingenSpel_pressed():
	self.visible=false


func _on_InstellingenShort_pressed():
	$Shortcuts.visible=true


func _on_ShortcutsSluiten_pressed():
	$Shortcuts.visible=false


func _on_Button_pressed():
	self.visible=true
