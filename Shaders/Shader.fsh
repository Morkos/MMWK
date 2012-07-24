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
uniform lowp float opacity;
uniform lowp float kernel[10];
const lowp float blurSize = 1.0/512.0;


lowp vec4 blurColor(in lowp vec4 color) {
    lowp vec4 sum = vec4(0.0, 0.0, 0.0, color.a);
    for (int i = -5; i < 5; i++) {
        if (i == 0) { continue; }
        lowp vec3 sampleColor = texture2D(textureSampler, texture_coordVarying).rgb;
        sampleColor *= kernel[i+5];
        sum += vec4(sampleColor, 0.0);
    }
    
    return sum;
}

void main()
{
    lowp vec4 color = texture2D(textureSampler, texture_coordVarying);
    
    // If alpha value == 0, don't draw the pixel at all
	// This is so that depth sorting would work
	if (color.a == 0.0) {
		discard;
	}
    
    // If opacity is non-negative, use that opacity for pixels
	if (opacity >= 0.0) {
		color.a *= opacity;
	}
    
     //lowp vec4 sum = vec4(0.0);
 
   // blur in y (vertical)
   // take nine samples, with the distance blurSize between them
   /*sum += texture2D(textureSampler, vec2(texture_coordVarying.x - 4.0*blurSize, texture_coordVarying.y)) * 0.05;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x - 3.0*blurSize, texture_coordVarying.y)) * 0.09;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x - 2.0*blurSize, texture_coordVarying.y)) * 0.12;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x - blurSize, texture_coordVarying.y)) * 0.15;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x, texture_coordVarying.y)) * 0.16;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x + blurSize, texture_coordVarying.y)) * 0.15;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x + 2.0*blurSize, texture_coordVarying.y)) * 0.12;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x + 3.0*blurSize, texture_coordVarying.y)) * 0.09;
   sum += texture2D(textureSampler, vec2(texture_coordVarying.x + 4.0*blurSize, texture_coordVarying.y)) * 0.05;
  */
    
    gl_FragColor = color;
}