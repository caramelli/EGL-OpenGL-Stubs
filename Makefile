PREFIX ?= /usr/local

CFLAGS += -g -O2 -fPIC

all: libEGL.so.1 libGLESv1_CM.so.1 libGLESv2.so.2

libEGL.so.1: EGL.c
libGLESv1_CM.so.1: GLESv1_CM.c
libGLESv2.so.2: GLESv2.c

libEGL.so.1 libGLESv1_CM.so.1 libGLESv2.so.2:
	$(CC) -Wall -shared -Wl,-soname,$@ $^ -o $@ $(CFLAGS) $(LDFLAGS)

clean:
	$(RM) *.so*

install: all
	install -d $(DESTDIR)$(PREFIX)/lib/pkgconfig
	install libEGL.so.1 libGLESv1_CM.so.1 libGLESv2.so.2 $(DESTDIR)$(PREFIX)/lib
	ln -sf libEGL.so.1 $(DESTDIR)$(PREFIX)/lib/libEGL.so
	ln -sf libGLESv1_CM.so.1 $(DESTDIR)$(PREFIX)/lib/libGLESv1_CM.so
	ln -sf libGLESv2.so.2 $(DESTDIR)$(PREFIX)/lib/libGLESv2.so
	install egl.pc glesv1_cm.pc glesv2.pc $(DESTDIR)$(PREFIX)/lib/pkgconfig
	sed -i 's|@prefix@|$(PREFIX)|' $(DESTDIR)$(PREFIX)/lib/pkgconfig/egl.pc
	sed -i 's|@prefix@|$(PREFIX)|' $(DESTDIR)$(PREFIX)/lib/pkgconfig/glesv1_cm.pc
	sed -i 's|@prefix@|$(PREFIX)|' $(DESTDIR)$(PREFIX)/lib/pkgconfig/glesv2.pc
