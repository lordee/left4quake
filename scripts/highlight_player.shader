highlight_player
{
    sort nearest
    {
        map textures/aedm7/dsitinfx.tga
        blendfunc blend
        //blendfunc gl_one gl_one
        tcGen environment
        alphagen const 0.2
        rgbgen const 1 0.5 0.5 //tinted red.
        nodepthtest   //disable depth tests (and writes)
    }
}