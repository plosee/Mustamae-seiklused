@tool
extends Label

const SLIDER_WARNING = "SliderLabel needs to be a child of a Slider control (HSlider or VSlider)."
const SLIDER_WARNING2 = "custom_slider_path needs to point to a Slider control (HSlider or VSlider)."

enum VisibilityRule {ON_CLICK, ON_HOVER, ON_FOCUS, ALWAYS}
enum Placement {TOP_RIGHT, BOTTOM_LEFT}

@export var visibility_rule: VisibilityRule: int = VisibilityRule.ON_HOVER
@export var placement: Placement: int = Placement.TOP_RIGHT
@export var separation := 4
@export var custom_format := ""
@export var custom_slider_path: NodePath: set = set_custom_path

var slider: Slider
var vertical: bool

func _enter_tree() -> void:
	if not has_meta("_edit_initialized_"):
		set_meta("_edit_initialized_", true)
		align = Label.ALIGNMENT_CENTER
		valign = Label.VALIGN_CENTER
		size_flags_horizontal = SIZE_SHRINK_CENTER
		text = "100"

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	if custom_slider_path.is_empty():
		slider = get_parent() as Slider
	else:
		slider = get_node(custom_slider_path) as Slider
	assert(slider != null) #,SLIDER_WARNING)
	
	if slider is VSlider:
		vertical = true
	
	slider.connect("value_changed", Callable(self, "update_with_discard"))
	
	if visibility_rule == VisibilityRule.ALWAYS:
		show()
	else:
		hide()
		
		match visibility_rule:
			VisibilityRule.ON_CLICK:
				slider.connect("gui_input", Callable(self, "_on_slider_gui_input"))
			VisibilityRule.ON_HOVER:
				slider.connect("mouse_entered", Callable(self, "_on_slider_hover_focus").bind(true))
				slider.connect("mouse_exited", Callable(self, "_on_slider_hover_focus").bind(false))
			VisibilityRule.ON_FOCUS:
				slider.connect("focus_entered", Callable(self, "_on_slider_hover_focus").bind(true))
				slider.connect("focus_exited", Callable(self, "_on_slider_hover_focus").bind(false))
	
	update_label()

func _on_slider_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		visible = event.pressed
		update_label()

func _on_slider_hover_focus(hover: bool):
	visible = hover
	update_label()

func _notification(what: int) -> void:
	if what == NOTIFICATION_PARENTED:
		update_configuration_warnings()

func update_with_discard(discard):
	update_label()

func update_label():
	if not is_visible_in_tree():
		return
	
	if custom_format.is_empty():
		text = str(slider.value)
	else:
		text = custom_format % slider.value
	
	hide()
	show()
	size = Vector2()
	
	var grabber_size := slider.get_icon("Grabber").get_size()
	if vertical:
		position.y = (1.0 - slider.ratio) * (slider.size.y - grabber_size.y) + grabber_size.y * 0.5 - size.y * 0.5
		if placement == Placement.TOP_RIGHT:
			position.x = slider.size.x + separation
		else:
			position.x = -size.x - separation
	else:
		position.x = slider.ratio * (slider.size.x - grabber_size.x) + grabber_size.x * 0.5 - size.x * 0.5
		if placement == Placement.TOP_RIGHT:
			position.y = -size.y - separation
		else:
			position.y = slider.size.y + separation

func _get_configuration_warnings() -> String:
	if custom_slider_path.is_empty():
		if not get_parent() is Slider:
			return SLIDER_WARNING
	else:
		if not get_node(custom_slider_path) is Slider:
			return SLIDER_WARNING2
	return ""

func set_custom_path(path: NodePath):
	custom_slider_path = path
	update_configuration_warnings()
