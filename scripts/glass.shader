glass_barrier
{
    qer_editorimage textures/aedm7/dsiglass_checker.tga
    qer_trans 0
    surfaceparm lightfilter // Use texture’s RGB and alpha channels to generate colored alpha shadows in the lightmap.
    surfaceparm nolightmap
    surfaceparm trans
    {
        map textures/aedm7/dsitinfx.tga
        blendfunc blend
        tcGen environment
        alphagen const 0.1 
    }
}