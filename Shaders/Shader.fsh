//
//  Shader.fsh
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//varying lowp vec4 colorVarying;
varying lowp vec2 texture_coordVarying;
uniform sampler2D textureSampler;

void main()
{
    gl_FragColor = texture2D(textureSampler, texture_coordVarying);
	
	// If alpha value == 0, don't draw the pixel at all
	// This is so that depth sorting would work
	if (gl_FragColor.a == 0.0) {
		discard;
	}
	
	//gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
	//gl_FragColor = colorVarying;
}
