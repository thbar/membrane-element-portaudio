#pragma once

#include <membrane/membrane.h>
#include <portaudio.h>
#include <stdio.h>
#include <string.h>

#include "pa_helper.h"

typedef struct _SourceState {
  int is_content_destroyed;
  PaStream *stream;
  UnifexPid destination; // Where capture thread will send messages
} SourceState;

typedef SourceState UnifexNifState;

#include "_generated/source.h"
