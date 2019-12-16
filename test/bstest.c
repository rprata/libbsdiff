#include <stdio.h>
#include <err.h>

#include "bsdiff.h"
#include "bspatch.h"

int main(int argc, char ** argv)
{
    if (argc != 4)  errx(1,"usage: %s oldfile newfile patchfile\n",argv[0]);

    bsdiff_exec(argv[1], argv[2], argv[3]);

    bspatch_exec(argv[1], argv[2], argv[3]);
    return 0;
}