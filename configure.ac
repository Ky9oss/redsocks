AC_INIT([redsocks], [1.0])

AM_INIT_AUTOMAKE([foreign subdir-objects tar-ustar])

LT_PREREQ([2.5.0])

LT_INIT([dlopen])

AC_CONFIG_SRCDIR([src/main.c])

AC_CONFIG_FILES([Makefile
                 src/Makefile])

AC_CONFIG_HEADERS([config.h])

AC_CONFIG_MACRO_DIRS([m4])

AC_PROG_CC
AC_PROG_INSTALL

AC_CHECK_PROG([bash_var], [bash], [yes], [no],, [/usr/sbin/bash])

AC_ARG_ENABLE([async-exec],
    [AS_HELP_STRING([--disable-async-exec],
        [disable asynchronous execution @<:@default: no@:>@])],
    [async_exec=${enableval}], [async_exec=yes])


have_pthreads=no
AC_SEARCH_LIBS([pthread_create], [pthread], [have_pthreads=yes])

if test "x${have_pthreads}" = xyes; then
    AC_CHECK_HEADERS([pthread.h], [], [have_pthreads=no])
fi

if test "x${have_pthreads}" = xno; then

    if test "x${async_exec}" = xyes; then

        AC_MSG_WARN([

  ------------------------------------------

  Unable to find pthreads on this system.

  Building a single-threaded version.

  ------------------------------------------])

    fi

    async_exec=no
fi

if test "x${async_exec}" = xyes; then

    AC_DEFINE([ASYNC_EXEC], [1], [async execution enabled])

fi

AC_OUTPUT
