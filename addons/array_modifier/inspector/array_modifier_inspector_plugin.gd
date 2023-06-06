extends EditorInspectorPlugin


func can_handle(object):
	return object.has_method("apply_array_modifier")


func parse_begin(object):
	if object.has_method("apply_array_modifier"):
		var button = Button.new()
		button.text = "Apply"
		button.tooltip_text = "Apply array modifier"
		button.align  = Button.ALIGNMENT_CENTER
		button.size_flags_horizontal = Button.SIZE_EXPAND_FILL
		button.connect("pressed", Callable(object, "apply_array_modifier"))
		add_custom_control(button)
