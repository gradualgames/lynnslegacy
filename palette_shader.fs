uniform sampler2D u_paletteTexture;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec4 pixelColor = texture2D(texture, texture_coords);

    float paletteIndex = pixelColor.r;

    vec2 paletteTextureCoords = vec2(paletteIndex, 0);
    vec3 outputPixelColor = texture2D(u_paletteTexture, paletteTextureCoords).rgb;
    return vec4(outputPixelColor,1.0);
}