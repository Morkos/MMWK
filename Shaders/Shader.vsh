//
//  Shader.vsh
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

attribute vec2 position;
uniform vec3 translate;
uniform vec2 scale;
uniform lowp float angle;

attribute vec2 texture_coord;

varying vec2 texture_coordVarying;

void main()
{
	mat2 scaleMat = mat2(scale.x, 0.0, 
						 0.0, scale.y);
						 
	mat2 rotateMat;
	if (angle >= 0.0) {
	  rotateMat = mat2(cos(angle), -sin(angle),
					   sin(angle), cos(angle));
	} else {
	  rotateMat = mat2(cos(-angle), sin(-angle),
					   -sin(-angle), cos(-angle));
	}
	
    gl_Position = vec4(scaleMat * rotateMat * position, 0.0, 1.0);
	
    gl_Position.x += translate.x;
    gl_Position.y += translate.y;
	gl_Position.z = translate.z;
	
	texture_coordVarying = texture_coord;
}
