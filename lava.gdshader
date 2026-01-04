shader_type canvas_item;

uniform vec4 base : source_color;
uniform float thresh : hint_range(0.0, 2.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dist = sqrt(pow(UV.x - 0.5, 2) + pow(UV.y - 0.5, 2)) * thresh;
	vec4 pixelColor = base * dist;
	COLOR = pixelColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
