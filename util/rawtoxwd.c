#include <unistd.h>
#include <arpa/inet.h>
#include <X11/X.h>
#include <X11/Xproto.h>
#include <X11/XWDFile.h>

static XWDFileHeader fh = {
    .header_size = sizeof(XWDFileHeader),
    .file_version = XWD_FILE_VERSION,
    .pixmap_format = ZPixmap,
    .pixmap_depth = 24,
    .pixmap_width = 1600,
    .pixmap_height = 900,
    .byte_order = LSBFirst,
    .bitmap_unit = 32,
    .bitmap_bit_order = LSBFirst,
    .bitmap_pad = 32,
    .bits_per_pixel = 24,
    .bytes_per_line = 4800,
    .visual_class = DirectColor,
    .red_mask = 0xff0000,
    .green_mask = 0x00ff00,
    .blue_mask = 0x0000ff,
    .bits_per_rgb = 8,
    .colormap_entries = 0,
    .ncolors = 0,
    .window_width = 1600,
    .window_height = 900,
};

int
main(int argc, char *argv[])
{
    int i;
    ssize_t rc;
    CARD32 pixel, *ptr;

    /* structure values are MSBFirst */
    ptr = (CARD32 *)&fh;
    for (i = 0; i < sizeof(fh); i+=4) {
	*ptr = htonl(*ptr);
	ptr++;
    }

    write(1, &fh, sizeof(fh));
    
    for (i = 0; i < 1600 * 900; i++) {
	rc = read(0, &pixel, 4);
	if (rc <= 0)
	    break;
	write(1, &pixel, 3);
    }

    return 0;
}
