; Uncompressed TGA with origin set to Top-Left and 256 color map
TGA_HEADER_COLORMAP equ 18 + 1028 ; 18 bytes header + 1028 bytes 256 colormap

bird:		file "../data/bird.tga"		: TGA_HEADER_COLORMAP, 96 * 24
grass:		file "../data/grass.tga"	: TGA_HEADER_COLORMAP,  8 * 4
pipe:		file "../data/pipe.tga"		: TGA_HEADER_COLORMAP, 32 * 2
pipe_top:	file "../data/pipe_top.tga"	: TGA_HEADER_COLORMAP, 36 * 4

flats:		file "../data/flats.tga"	: TGA_HEADER_COLORMAP, 40 * 50
clouds:		file "../data/cloud.tga"	: TGA_HEADER_COLORMAP, 40 * 16
font:		file "../data/font.tga"		: TGA_HEADER_COLORMAP, 80 * 8
