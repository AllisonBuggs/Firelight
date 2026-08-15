shader_type canvas_item;

uniform float jiggle = 0.0;
uniform float speed = 0.0;

void vertex() {
	VERTEX.y += VERTEX_ID % 2 == 0 ? cos((TIME * speed) + VERTEX.x + float(VERTEX_ID * 10)) * jiggle : sin((TIME * speed) + VERTEX.x + float(VERTEX_ID * 10)) * jiggle;
}