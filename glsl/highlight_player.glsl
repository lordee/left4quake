!!ver 330
!!samps dif:sampler2D=0
!!samps dept:sampler2D=1
#include "sys/defs.h"
varying vec2 v_edge;

#ifdef VERTEX_SHADER
void main(void)
{
   gl_Position = ftetransform();
   v_edge = v_texcoord.xy;
}
#endif
#ifdef FRAGMENT_SHADER

void main(void)
{
   vec4 color = texture2D(s_dif,v_edge);
   vec4 depth = texture2D(s_dept,v_edge);
   //float depthval = depth.x*10.0;
   gl_FragColor = vec4(0, .5, 0, 1);
}
#endif