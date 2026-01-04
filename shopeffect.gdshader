shader_type canvas_item;

uniform vec4 main : source_color;
uniform float distscale : hint_range(0.0, 2.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dist = sqrt(pow(UV.x, 2) + pow(UV.y, 2)) * distscale;
	COLOR = main * dist;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
