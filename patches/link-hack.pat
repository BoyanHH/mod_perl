Index: src/build/program.mk
===================================================================
RCS file: /home/cvs/apache-2.0/src/build/program.mk,v
retrieving revision 1.3
diff -u -u -r1.3 program.mk
--- src/build/program.mk	2000/03/31 07:02:31	1.3
+++ src/build/program.mk	2000/04/16 23:43:14
@@ -54,7 +54,10 @@
 # The build environment was provided by Sascha Schumann.
 #
 
+MP_SRC = ../../modperl-2.0/src/modules/perl
+MP_LDADD = $(MP_SRC)/libmodperl.a `$(MP_SRC)/ldopts`
+
 PROGRAM_OBJECTS = $(PROGRAM_SOURCES:.c=.lo)
 
 $(PROGRAM_NAME): $(PROGRAM_DEPENDENCIES) $(PROGRAM_OBJECTS)
-	$(LINK) $(PROGRAM_LDFLAGS) $(PROGRAM_OBJECTS) $(PROGRAM_LDADD)
+	$(LINK) $(PROGRAM_LDFLAGS) $(PROGRAM_OBJECTS) $(PROGRAM_LDADD) $(MP_LDADD)

--- src/modules.c~	Wed Apr 12 20:00:23 2000
+++ src/modules.c	Wed Apr 12 20:10:16 2000
@@ -26,6 +26,7 @@
 extern module auth_module;
 extern module setenvif_module;
 extern module echo_module;
+extern module perl_module;
 
 /*
  *  Modules which implicitly form the
@@ -54,6 +55,7 @@
   &auth_module,
   &setenvif_module,
   &echo_module,
+  &perl_module,
   NULL
 };
 
@@ -84,6 +86,7 @@
   &auth_module,
   &setenvif_module,
   &echo_module,
+  &perl_module,
   NULL
 };

